"""主题 10：资源管理 —— Python 版
CPython 是“引用计数 + 循环 GC”双轨：简单对象的析构是确定性的（引用归零即回收），
但池化资源（文件、连接、锁）的归还纪律不靠 GC——靠 with 语句（上下文管理器）。
本题用 BufferPool 演示：GC 管内存，资源归还靠约定。
"""


class BufferPool:
    def acquire(self, name: str) -> str:
        print(f"allocate buffer {name}")
        return name

    def release(self, buf: str) -> None:
        print(f"return {buf} to pool")


if __name__ == "__main__":
    pool = BufferPool()
    a = pool.acquire("A")
    b = pool.acquire("B")
    print(f"use {a} + {b}")
    pool.release(a)
    pool.release(b)
    print("all buffers back in pool")
