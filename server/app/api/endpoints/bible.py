from dependency_injector.wiring import Provide
from fastapi import APIRouter, Depends, HTTPException
import requests

from app.core.config import configs
from app.services.bible_service import BibleService

router = APIRouter(
    prefix="/bible",
    tags=["bible"],
)

bible_service = BibleService(api_base_url=configs.BIBLE_API_BASE_URL)

# get all books of the WEB Bible
@router.get("/all-books")
def all_books():
    try:
        return bible_service.all_books()
    except requests.HTTPError as e:
        raise HTTPException(status_code=e.response.status_code, detail=e.response.text)

# get number of chapters for a book


# get an entire chapter of a book