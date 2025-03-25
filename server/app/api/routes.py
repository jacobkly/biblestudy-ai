from fastapi import APIRouter

routers = APIRouter()
router_list = []

for router in router_list:
    router.include_router(router)