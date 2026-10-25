"""主题 01：泛型 Generics —— Python 版
Python 是动态类型 + 鸭子类型，泛型主要是“注解层面的约定”：
运行时本来就不需要声明类型，TypeVar / Generic 给类型检查器（mypy、pyright）看的。
"""
from typing import TypeVar, Generic, Callable

T = TypeVar("T")
U = TypeVar("U")


class Box(Generic[T]):
    """一个泛型盒子：装任何类型，并能用 map 做类型变换。"""

    def __init__(self, value: T):
        self._value = value

    def get(self) -> T:
        return self._value

    def map(self, f: Callable[[T], U]) -> "Box[U]":
        return Box(f(self._value))


def first(items: list[T]) -> T:
    """取列表第一个元素——对任何列表都成立，无需声明元素类型。"""
    return items[0]


if __name__ == "__main__":
    print("int box:", Box(42).get())
    print("str box:", Box("hello").get())
    print("first of [10, 20, 30] =", first([10, 20, 30]))
    print("doubled 21 ->", Box(21).map(lambda x: x * 2).get())
