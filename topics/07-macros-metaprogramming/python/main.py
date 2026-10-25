"""主题 07：宏与元编程 —— Python 版
Python 没有宏。它的元编程层次是：
装饰器（函数级，运行期）→ 描述符 → 元类（类级，运行期）。
装饰器本质就是“包一层”的高阶函数。
"""

def logged(fn):
    """装饰器：返回包装后的函数，调用时先打印日志。"""
    def wrapper(*args, **kwargs):
        return fn(*args, **kwargs)
    return wrapper


@logged  # 等价于 square = logged(square)
def square(x: int) -> int:
    return x * x


@logged
def cube(x: int) -> int:
    return x * x * x


if __name__ == "__main__":
    print("square(7) =", square(7))
    print("cube(3) =", cube(3))
