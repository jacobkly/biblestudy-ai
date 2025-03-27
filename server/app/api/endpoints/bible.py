import requests
from fastapi import APIRouter, HTTPException, Path
from typing import List


from app.core.config import configs
from app.services.bible_service import BibleService
from app.schema.bible_schema import BookInfo, ChapterInfo, Chapter

router = APIRouter(
    prefix="/bible",
    tags=["bible"],
)

bible_service = BibleService(api_base_url=configs.BIBLE_API_BASE_URL)

# get all books of the WEB Bible with some extra information for each book
@router.get("/books", response_model=List[BookInfo]) 
def get_books():
    try:
        return bible_service.get_books()
    except requests.HTTPError as e:
        raise HTTPException(status_code=e.response.status_code, detail=e.response.text)

# get all chapters for a book with some extra information for each chapter
@router.get("/books/{bookId}/chapters")
def get_all_chapters(book_id: str = Path(..., alias="bookId"), response_model=List[ChapterInfo]):
    try:
        return bible_service.get_all_chapters(book_id)
    except requests.HTTPError as e:
        raise HTTPException(status_code=e.response.status_code, detail=e.response.text)

# get an entire chapter of a book in HTML (other options are JSON or plain text) with some extra information
@router.get("/chapters/{chapterId}")
def get_chapter(chapter_id: str = Path(..., alias="chapterId"), response_model=Chapter):
    try:
        return bible_service.get_chapter(chapter_id)
    except requests.HTTPError as e:
        raise HTTPException(status_code=e.response.status_code, detail=e.response.text)