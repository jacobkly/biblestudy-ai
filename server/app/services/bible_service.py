import requests

from app.core.config import configs
from app.util.bible_util import remove_keys, text_to_html


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
        url = f"{self.api_base_url}/bibles/{configs.WEB_BIBLE_ID}/chapters/{chapter_id}?content-type=text"
        response = requests.get(url, headers=configs.API_HEADER)
        response.raise_for_status()

        # clean up JSON object by removing unnecessary key value pairs
        data = response.json()["data"]
        chapter = remove_keys(
            data, ["bibleId", "bookId", "reference", "copyright", "verseCount"]
        )
        chapter.update(
            {
                "next_id": chapter.pop("next", {}).get("id"),
                "previous_id": chapter.pop("previous", {}).get("id"),
            }
        )

        # convert plain text to HTML for the app
        chapter["content"] = text_to_html(chapter["content"])

        return chapter
