from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.util.class_object import singleton
from app.util.bible_util import populate_edge_ids
from app.core.config import configs
from app.api.routes import routers


@singleton
class AppCreator:
    def __init__(self):
        # set app default
        self.app = FastAPI(
            title=configs.PROJECT_NAME,
            openapi_url=f"{configs.API}/openapi.json",
            version="0.0.1",
        )

        # set CORS
        if configs.BACKEND_CORS_ORIGINS:
            self.app.add_middleware(
                CORSMiddleware,
                allow_origins=[str(origin) for origin in configs.BACKEND_CORS_ORIGINS],
                allow_credentials=True,
                allow_methods=["GET"],  # for now as there is no user or chatbot ability
                allow_headers=["*"],
            )

        # set Bible utilities
        populate_edge_ids()

        # set routes
        @self.app.get("/")
        def root():
            return "FastAPI server is working!"

        self.app.include_router(routers, prefix=configs.API)


app_creator = AppCreator()
app = app_creator.app
