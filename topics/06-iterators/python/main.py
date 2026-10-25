"""主题 06：迭代器与流 —— Python 版
生成器（generator）是惰性的核心机制：yield 挂起/恢复函数状态。
生成器表达式 (x*10 for ...) 和列表推导 [x*10 for ...] 的区别
就在于惰性 vs 立即求值——这是 Python 里最实用的性能常识。
"""
from itertools import islice


def evens_doubled():
    for x in range(1, 11):
        if x % 2 == 0:
            yield x * 10


if __name__ == "__main__":
    print("evens doubled:", *evens_doubled())
    print("first 3:", *islice(evens_doubled(), 3))  # islice 惰性取前 3 个
    print("sum =", sum(evens_doubled()))
