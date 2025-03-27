from pydantic import BaseModel
from typing import List


class InnerChapter(BaseModel):
    id: str
    number: str

class BooksChapters(BaseModel):
    id: str
    name: str
    chapters: List[InnerChapter]

class Chapter(BaseModel):
    id: str
    number: str
    content: str
    next_id: str
    previous_id: str