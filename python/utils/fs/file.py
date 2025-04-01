from returns.io import impure_safe
from pathlib import Path


@impure_safe
def read_file(file_path: Path, binary_mode: bool = False) -> str:
    mode = "rb" if binary_mode else "r"
    encoding = None if binary_mode else "utf-8"
    with open(file_path, mode, encoding=encoding) as f:
        return f.read()


@impure_safe
def write_file(file_path: Path, content: str, binary_mode: bool = False) -> None:
    mode = "wb" if binary_mode else "w"
    encoding = None if binary_mode else "utf-8"
    with open(file_path, mode, encoding=encoding) as f:
        f.write(content)
