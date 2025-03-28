import os
from typing import List

from dotenv import load_dotenv
from pydantic_settings import BaseSettings

load_dotenv()

ENV: str = ""


class Configs(BaseSettings):
    # base
    ENV: str = os.getenv("ENV", "dev")
    API: str = "/api"
    PROJECT_NAME: str = "bsa-api"
    ENV_DATABASE_MAPPER: dict = {
        "prod": "bsa",
        "stage": "stage-bsa",
        "dev": "dev-bsa",
        "test": "test-bsa",
    }

    PROJECT_ROOT: str = os.path.dirname(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    )

    # auth
    SECRET_KEY: str = os.getenv("SECRET_KEY", "")
    ACCESS_TOKEN_EXPIRE_MINUTES: int = (
        60 * 24 * 30
    )  # 60 minutes * 24 hours * 30 days = 30 days

    # CORS
    BACKEND_CORS_ORIGINS: List[str] = [os.getenv("DEV_URL")]

    # database
    DB: str = os.getenv("DB")
    DB_USER: str = os.getenv("DB_USER")
    DB_PASSWORD: str = os.getenv("DB_PASSWORD")
    DB_HOST: str = os.getenv("DB_HOST")
    DB_PORT: str = os.getenv("DB_PORT")
    DB_ENGINE: str = DB

    DATABASE_URI_FORMAT: str = (
        "{db_engine}://{user}:{password}@{host}:{port}/{database}"
    )

    DATABASE_URI: str = (
        "{db_engine}://{user}:{password}@{host}:{port}/{database}".format(
            db_engine=DB_ENGINE,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT,
            database=ENV_DATABASE_MAPPER[ENV],
        )
    )

    BIBLE_API_KEY: str = os.getenv("BIBLE_API_KEY")
    API_HEADER: dict = {"api-key": BIBLE_API_KEY}
    BIBLE_API_BASE_URL: str = os.getenv("BIBLE_API_BASE_URL")
    WEB_BIBLE_ID: str = os.getenv("WEB_BIBLE_ID")

    class Config:
        case_sensitive = True


configs = Configs()
