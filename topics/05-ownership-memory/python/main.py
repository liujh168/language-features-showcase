"""主题 05：所有权与内存 —— Python 版
Python 是 GC 语言：内存由引用计数 + 循环垃圾回收器托管，
析构时机不确定（CPython 引用计数为 0 即回收，但逻辑上别依赖）。
确定性的清理靠 with 语句（上下文管理器协议：__enter__/__exit__）。
"""

class Resource:
    def __init__(self, rid: int):
        self.rid = rid

    def __enter__(self) -> "Resource":
        print(f"acquire resource #{self.rid}")
        return self

    def __exit__(self, *exc_info) -> None:
        print(f"release resource #{self.rid}")


if __name__ == "__main__":
    with Resource(1) as r:   # 进入时 acquire，离开 with 块时必定 release
        print(f"use resource #{r.rid}")
    print("done")
