from pydantic import BaseModel

class BooksChapters(BaseModel):
    id: str
    name: str
    num_chapters: str


class Chapter(BaseModel):
    id: str
    number: str
    content: str
    next_id: str
    previous_id: str
