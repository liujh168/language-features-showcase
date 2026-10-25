"""主题 04：错误处理 —— Python 版
异常（exception）是唯一错误机制：失败靠抛出/捕获。
哲学与 Rust/Go 相反——“宁可请求原谅，不要事先许可”（EAFP）。
"""

def parse_positive(s: str) -> int:
    try:
        return int(s)
    except ValueError:
        raise ValueError("invalid digit")


def div(a: int, b: int) -> int:
    if b == 0:
        raise ZeroDivisionError("division by zero")
    return a // b


def show_parse(s: str) -> None:
    try:
        print(f'parse "{s}" -> {parse_positive(s)}')
    except ValueError as e:
        print(f'parse "{s}" -> error: {e}')


def show_div(a: int, b: int) -> None:
    try:
        print(f"{a} / {b} = {div(a, b)}")
    except ZeroDivisionError as e:
        print(f"{a} / {b} -> error: {e}")


if __name__ == "__main__":
    show_parse("42")
    show_parse("abc")
    show_div(10, 2)
    show_div(10, 0)
