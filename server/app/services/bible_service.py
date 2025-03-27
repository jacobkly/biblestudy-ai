import requests

from app.core.config import configs

class BibleService:
    def __init__(self, api_base_url: str):
        self.api_base_url = api_base_url.rstrip("/")

    def get_books(self):
        url = f"{self.api_base_url}/bibles/{configs.WEB_BIBLE_ID}/books"
        response = requests.get(url, headers=configs.API_HEADER)
        response.raise_for_status()

        # remove "bibleId" and "abbrevation" from json objects
        data = response.json()
        books = data.get("data", [])
        for book in books:
            book.pop("bibleId", None)
            book.pop("abbreviation", None)

        return books

    def get_all_chapters(self, book_id: str):
        url = f"{self.api_base_url}/bibles/{configs.WEB_BIBLE_ID}/books/{book_id}/chapters"
        response = requests.get(url, headers=configs.API_HEADER)
        response.raise_for_status()

        # remove "bibleId" and "reference" from json objects
        data = response.json()
        all_chapters = data.get("data", [])
        for chapter in all_chapters:
            chapter.pop("bibleId", None)
            chapter.pop("reference", None)

        return all_chapters
    
    def get_chapter(self, chapter_id: str):
        url = f"{self.api_base_url}/bibles/{configs.WEB_BIBLE_ID}/chapters/{chapter_id}?content-type=html"
        response = requests.get(url, headers=configs.API_HEADER)
        response.raise_for_status()

        # clean up JSON object by removing unnecessary key value pairs
        chapter = response.json()["data"]
        for key in ["bibleId", "bookId", "reference", "copyright", "verseCount"]:
            chapter.pop(key, None)
        chapter.update({
            "next_id": chapter.pop("next", {}).get("id"),
            "previous_id": chapter.pop("previous", {}).get("id")
        })

        return chapter