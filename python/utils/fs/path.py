from pathlib import Path
from returns.io import impure
from pydantic import BaseModel
import os
from typing import Generator


class Walk_info(BaseModel):
    dirpath: str
    dirnames: list[str]
    filenames: list[str]


@impure
def walk(root_dir: Path) -> Generator[Walk_info, None, None]:
    for dirpath, dirnames, filenames in os.walk(root_dir):
        yield Walk_info(dirpath=dirpath, dirnames=dirnames, filenames=filenames)
