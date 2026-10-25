"""主题 12：异步进阶 —— Python 版
asyncio：单线程事件循环 + 协程。await asyncio.sleep 期间协程挂起，
事件循环转去跑其他任务——与 TypeScript 的模型几乎同构。
对比主题 02 的线程池：协程比线程轻几个数量级，适合海量 IO 任务。
"""

import asyncio


async def work(name: str, ms: int) -> None:
    await asyncio.sleep(ms / 1000)  # 挂起点：让出事件循环
    print(f"task {name} finished")


async def main() -> None:
    print("start 3 tasks")
    # create_task 同时启动三个协程；完成顺序 = sleep 长短
    await asyncio.gather(
        work("fast", 10),
        work("medium", 100),
        work("slow", 300),
    )
    print("all settled")


if __name__ == "__main__":
    asyncio.run(main())  # 事件循环入口
