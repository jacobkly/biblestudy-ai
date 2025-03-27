import requests
from fastapi import APIRouter, HTTPException, Path
from typing import List

from app.core.config import configs
from app.services.bible_service import BibleService
from app.schema.bible_schema import Chapter, BooksChapters

router = APIRouter(
    prefix="/bible",
    tags=["bible"],
)

bible_service = BibleService(api_base_url=configs.BIBLE_API_BASE_URL)
    
# get all books and respective chapters of the bible
@router.get("/books/chapters", response_model=List[BooksChapters])
def get_books_chapters():
    try:
        return bible_service.get_books_chapters()
    except requests.HTTPError as e:
        raise HTTPException(status_code=e.response.status_code, detail=e.response.text)

# get an entire chapter of a book in HTML (other options are JSON or plain text) with some extra information
@router.get("/chapters/{chapterId}")
def get_chapter(chapter_id: str = Path(..., alias="chapterId"), response_model=Chapter):
    try:
        return bible_service.get_chapter(chapter_id)
    except requests.HTTPError as e:
        raise HTTPException(status_code=e.response.status_code, detail=e.response.text)