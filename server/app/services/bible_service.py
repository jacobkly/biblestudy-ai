import requests

from app.core.config import configs
from app.util.helpers import remove_keys, text_to_html


class BibleService:
    def __init__(self, api_base_url: str):
        self.api_base_url = api_base_url.rstrip("/")

    def get_books_chapters(self):
        url = f"{self.api_base_url}/bibles/{configs.WEB_BIBLE_ID}/books?include-chapters=true"
        response = requests.get(url, headers=configs.API_HEADER)
        response.raise_for_status()

        data = response.json().get("data", [])
        for book in data:
            num_chapters = book["chapters"][-1]["number"]
            book["num_chapters"] = num_chapters
            book = remove_keys(book, ["bibleId", "abbreviation", "nameLong", "chapters"])

        return data

    def get_chapter(self, chapter_id: str):
        from app.util.bible_util import prev_edge_id, next_edge_id

        url = f"{self.api_base_url}/bibles/{configs.WEB_BIBLE_ID}/chapters/{chapter_id}?content-type=text"
        response = requests.get(url, headers=configs.API_HEADER)
        response.raise_for_status()

        chapter = response.json()["data"]

        # Get previous and next edge chapter ids as Bible API doesn't give expected ids
        prev_id, next_id = None, None
        if chapter_id.split(".")[1] == "1":
            prev_id = prev_edge_id(chapter["bookId"])
        if chapter.get("next", {}).get("id", "").endswith(".intro"):
            next_book_id = chapter["next"]["bookId"]
            next_id = next_edge_id(next_book_id)
        if not next_id:
            next_id = chapter.get("next", {}).get("id")
        if not prev_id:
            prev_id = chapter.get("previous", {}).get("id")

        chapter.update({
            "next_id": next_id,
            "previous_id": prev_id,
        })

        # Clean up JSON object by removing unnecessary key value pairs
        chapter = remove_keys(
            chapter, ["bibleId", "bookId", "copyright", "verseCount", "next", "previous"]
        )

        # Convert on my own as Bible API HTML response is not the cleanest
        chapter["content"] = text_to_html(chapter["content"])

        return chapter
