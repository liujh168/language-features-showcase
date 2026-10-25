"""主题 11：模块与封装 —— Python 版
Python 的“模块”就是一个 .py 文件；封装靠**命名约定**而非强制：
_单下划线前缀 = “内部实现，别用”（from x import * 时不会被导出）。
真要强约束，靠类型检查器（mypy）识别 __all__ 和私有名。
"""


def _decorate(s: str) -> str:
    return s + " from utils"  # 单下划线 = 模块私有约定


def greet() -> str:
    return _decorate("hello")


def area(w: int, h: int) -> int:
    return w * h


class User:
    def __init__(self, name: str):
        self._name = name  # “私有”字段：约定 + 名称改写（name mangling 是双下划线的事）

    def __repr__(self) -> str:
        return f"User(name={self._name})"


def make_user(name: str) -> User:
    return User(name)


if __name__ == "__main__":
    print(f"utils.greet() = {greet()}")
    print(f"area(3, 4) = {area(3, 4)}")
    print(f'makeUser("ada") = {make_user("ada")}')
