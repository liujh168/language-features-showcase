"""主题 03：模式匹配 —— Python 版
match-case（3.10+）支持字面量、捕获绑定、守卫（if 子句）。
case _ 是兜底；Python 不像 Rust 那样强制穷尽性检查。
"""

def classify(n: int) -> str:
    match n:
        case 0:
            return "zero"
        case 1:
            return "one"
        case n if n < 0:      # 守卫
            return "negative"
        case n if n % 2 == 0:
            return "even"
        case _:               # 通配兜底
            return "odd"


if __name__ == "__main__":
    for n in [0, 1, -3, 42, 7]:
        print(f"classify({n}) = {classify(n)}")
