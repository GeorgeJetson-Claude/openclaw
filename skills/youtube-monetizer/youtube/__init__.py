"""
YouTube integration for the youtube-monetizer skill.

Reuses the standard ~/.youtube/ OAuth setup (client_secret.json + token.pickle).
"""

from .client import YouTubeClient, get_youtube_client

__all__ = ["YouTubeClient", "get_youtube_client"]
