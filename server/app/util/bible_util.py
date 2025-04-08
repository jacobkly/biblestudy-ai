from app.core.config import configs
from app.services.bible_service import BibleService


# map book id to [previous id, next id]
edge_book_chapter_ids = {}

def populate_edge_ids():
    bible_service = BibleService(api_base_url=configs.BIBLE_API_BASE_URL)
    books_chapters_data = bible_service.get_books_chapters()
    num_books = len(books_chapters_data)

    for i in range(num_books):
        edge_book_chapter_ids[books_chapters_data[i]["id"]] = ["", ""]

    for i in range(num_books):
        # Set previous edge book chapter id
        if i:
            prev_id = books_chapters_data[i-1]["id"]
            prev_last_chapter = books_chapters_data[i-1]["num_chapters"]
            edge_book_chapter_ids[books_chapters_data[i]["id"]][0] = f"{prev_id}.{prev_last_chapter}"

        # Set next edge book chapter id
        if i+1 < num_books:
            next_id = books_chapters_data[i+1]["id"]
            edge_book_chapter_ids[books_chapters_data[i+1]["id"]][1] = f"{next_id}.1"

def prev_edge_id(book_id):
    if book_id == "GEN":
        return "GEN.1" # first chapter
    return edge_book_chapter_ids[book_id][0]


def next_edge_id(book_id):
    if book_id == "REV":
        return "REV.22" # last chapter
    return edge_book_chapter_ids[book_id][1]