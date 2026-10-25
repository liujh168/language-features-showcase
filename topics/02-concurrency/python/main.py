"""主题 02：并发模型 —— Python 版
Python 的并发哲学：IO 密集用线程/协程（受 GIL 限制，线程不并行 CPU），
CPU 密集用多进程。这里演示线程池模型：ThreadPoolExecutor。
"""
from concurrent.futures import ThreadPoolExecutor


def work(i: int) -> tuple[int, int]:
    """模拟耗时任务（网络请求、文件读写等 IO）。GIL 在等待时会被释放，
    所以线程池跑 IO 任务依然是并发的。"""
    return i, i * 10


if __name__ == "__main__":
    print("start 4 workers")
    # 线程池：提交 4 个任务，主线程在 f.result() 处汇合（join）
    with ThreadPoolExecutor(max_workers=4) as pool:
        futures = [pool.submit(work, i) for i in range(1, 5)]
        results = [f.result() for f in futures]

    results.sort()  # 并发完成顺序不确定，排序保证输出确定
    for i, v in results:
        print(f"result from worker {i}: {v}")
    print("all done")
