#!/usr/bin/env python3
"""
YouTube Client for OpenClaw youtube-monetizer skill.

Wraps the existing ~/.youtube/ OAuth credentials (client_secret.json + token.pickle)
that were set up via the standard youtube_authenticate.py flow.

This keeps the skill consistent with the user's existing auth setup.
"""

from __future__ import annotations

import os
import pickle
from pathlib import Path
from typing import Optional

from google.auth.transport.requests import Request
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaFileUpload

# Scopes needed for full YouTube monetizer use case
SCOPES = [
    "https://www.googleapis.com/auth/youtube",
    "https://www.googleapis.com/auth/youtube.upload",
    "https://www.googleapis.com/auth/youtube.force-ssl",
]

# Standard location used across the user's setup
YOUTUBE_DIR = Path.home() / ".youtube"
CLIENT_SECRET_FILE = YOUTUBE_DIR / "client_secret.json"
TOKEN_FILE = YOUTUBE_DIR / "token.pickle"


class YouTubeClient:
    """Thin, reusable wrapper around YouTube Data API v3."""

    def __init__(self, credentials_dir: Optional[Path] = None):
        self.credentials_dir = credentials_dir or YOUTUBE_DIR
        self._service = None

    @property
    def service(self):
        if self._service is None:
            self._service = self._get_authenticated_service()
        return self._service

    def _get_authenticated_service(self):
        """Load or refresh credentials and return a YouTube service client."""
        creds = None

        token_path = self.credentials_dir / "token.pickle"
        secret_path = self.credentials_dir / "client_secret.json"

        if token_path.exists():
            with open(token_path, "rb") as token:
                creds = pickle.load(token)

        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                if not secret_path.exists():
                    raise FileNotFoundError(
                        f"Missing client_secret.json at {secret_path}. "
                        "Run the standard youtube_authenticate.py flow first."
                    )
                flow = InstalledAppFlow.from_client_secrets_file(secret_path, SCOPES)
                creds = flow.run_local_server(port=0)

            # Save the credentials for the next run
            token_path.parent.mkdir(parents=True, exist_ok=True)
            with open(token_path, "wb") as token:
                pickle.dump(creds, token)

        return build("youtube", "v3", credentials=creds)

    # ------------------------------------------------------------------
    # Core operations
    # ------------------------------------------------------------------

    def upload_video(
        self,
        file_path: str | Path,
        title: str,
        description: str = "",
        tags: Optional[list[str]] = None,
        category_id: str = "24",  # Entertainment by default
        privacy_status: str = "private",
        publish_at: Optional[str] = None,
    ) -> dict:
        """
        Upload a video.

        privacy_status: 'private', 'unlisted', 'public'
        publish_at: ISO8601 string for scheduled publishing (requires public/unlisted)
        """
        file_path = Path(file_path)
        if not file_path.exists():
            raise FileNotFoundError(f"Video file not found: {file_path}")

        body = {
            "snippet": {
                "title": title,
                "description": description,
                "tags": tags or [],
                "categoryId": category_id,
            },
            "status": {
                "privacyStatus": privacy_status,
            },
        }

        if publish_at and privacy_status != "private":
            body["status"]["publishAt"] = publish_at

        media = MediaFileUpload(
            str(file_path),
            chunksize=-1,
            resumable=True,
            mimetype="video/*",
        )

        request = self.service.videos().insert(
            part=",".join(body.keys()),
            body=body,
            media_body=media,
        )

        response = None
        while response is None:
            status, response = request.next_chunk()
            if status:
                print(f"Uploaded {int(status.progress() * 100)}%")

        print(f"✅ Upload complete. Video ID: {response['id']}")
        return response

    def update_video_metadata(
        self,
        video_id: str,
        title: Optional[str] = None,
        description: Optional[str] = None,
        tags: Optional[list[str]] = None,
    ) -> dict:
        """Update title, description, or tags on an existing video."""
        # First get current data
        current = (
            self.service.videos()
            .list(part="snippet", id=video_id)
            .execute()
        )

        if not current.get("items"):
            raise ValueError(f"Video not found: {video_id}")

        snippet = current["items"][0]["snippet"]

        if title:
            snippet["title"] = title
        if description:
            snippet["description"] = description
        if tags is not None:
            snippet["tags"] = tags

        body = {
            "id": video_id,
            "snippet": snippet,
        }

        return (
            self.service.videos()
            .update(part="snippet", body=body)
            .execute()
        )

    def add_comment(self, video_id: str, text: str, pin: bool = False) -> dict:
        """Post a comment. Optionally pin it (requires channel owner)."""
        comment = (
            self.service.commentThreads()
            .insert(
                part="snippet",
                body={
                    "snippet": {
                        "videoId": video_id,
                        "topLevelComment": {"snippet": {"textOriginal": text}},
                    }
                },
            )
            .execute()
        )

        if pin:
            # Pinning requires moderator privileges on the channel
            try:
                self.service.comments().setModerationStatus(
                    id=comment["snippet"]["topLevelComment"]["id"],
                    moderationStatus="published",
                ).execute()
                # Note: actual pinning often still needs YouTube Studio or additional calls
            except HttpError as e:
                print(f"Warning: Could not moderate/pin comment: {e}")

        return comment

    def get_channel_info(self) -> dict:
        """Return basic info about the authenticated channel."""
        return (
            self.service.channels()
            .list(part="snippet,statistics,contentDetails", mine=True)
            .execute()
        )

    def list_my_videos(self, max_results: int = 10) -> list[dict]:
        """List recent uploads from the authenticated channel."""
        uploads_playlist = (
            self.get_channel_info()["items"][0]["contentDetails"]["relatedPlaylists"]["uploads"]
        )

        playlist_items = (
            self.service.playlistItems()
            .list(
                part="snippet,contentDetails",
                playlistId=uploads_playlist,
                maxResults=max_results,
            )
            .execute()
        )

        return playlist_items.get("items", [])


# Convenience function for quick use in scripts
def get_youtube_client() -> YouTubeClient:
    return YouTubeClient()


if __name__ == "__main__":
    # Quick smoke test
    yt = get_youtube_client()
    info = yt.get_channel_info()
    print("Authenticated as:", info["items"][0]["snippet"]["title"])
    print("Subscribers:", info["items"][0]["statistics"].get("subscriberCount", "hidden"))
