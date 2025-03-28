from fastapi import APIRouter

from app.api.endpoints.bible import router as bible_router

routers = APIRouter()
router_list = [bible_router]

for router in router_list:
    routers.include_router(router)
