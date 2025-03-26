import requests
import json

from app.core.config import configs

class BibleService:
    def __init__(self, api_base_url: str):
        self.api_base_url = api_base_url.rstrip("/")

    def all_books(self):
        bible_id = configs.WEB_BIBLE_ID
        url = f"{self.api_base_url}/bibles/{bible_id}/books"
        headers = {"api-key": configs.BIBLE_API_KEY}
        response = requests.get(url, headers=headers)
        response.raise_for_status()

        # remove book "abbrevation" from json objects
        data = response.json()
        books = data.get("data", [])
        for book in books:
            book.pop("abbreviation", None)

        return books
