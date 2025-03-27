from pydantic import BaseModel


class BookInfo(BaseModel):
    id: str
    name: str
    nameLong: str

class ChapterInfo(BaseModel):
    id: str
    bookId: str
    number: str

class Chapter(BaseModel):
    id: str
    number: str
    content: str
    next_id: str
    previous_id: str