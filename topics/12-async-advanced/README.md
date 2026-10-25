# 主题 12：异步生态进阶

> 同一道题：fast(10ms) / medium(100ms) / slow(300ms) 三个任务**同时**开跑，
> 按**完成顺序**输出，全部结束后打印 all settled。
> 主题 02 看“怎么起线程”，本题看“异步编排”——完成竞赛 + 汇合。
> 交互展示页：[ui/index.html](ui/index.html)

## 题目

```
start 3 tasks
task fast finished
task medium finished
task slow finished
all settled
```

## 六语言编排机制对比

| 语言 | 任务启动 | 汇合原语 | 底层模型 |
|---|---|---|---|
| TypeScript | 调 async 函数 | `Promise.all` | 单线程事件循环 |
| Python | `asyncio.create_task` | `asyncio.gather` | 单线程事件循环（同 TS） |
| Go | `go` 关键字 | channel 接收循环 | M:N 调度 goroutine |
| Rust | async 函数 + tokio | `tokio::join!` | 多线程 work-stealing 调度器 |
| C++ | `std::async` | `future.get()` | 系统线程（无标准协程运行时） |
| Java | `CompletableFuture.runAsync` | `allOf().join()` | ForkJoinPool / 虚拟线程 |

## 关键认知

1. **async/await 只是语法糖**：真正干活的是运行时（事件循环 / 调度器）。
   Rust 把运行时留给了生态（tokio），Python 内置 asyncio，JS 内置于引擎——对比它们等于对比调度哲学。
2. **Go 没有 async 关键字**：`go` + channel 已经完成了别家 async/await + Promise 的事——
   “不要通过共享内存通信，要通过通信共享内存”。
3. **C++ 的缺口**：C++20 协程只有语言层原语，标准库运行时至今缺席（`std::execution` 仍在路上），
   工程上要么手写调度器，要么退回线程池。
4. **Java 的双轨**：传统 CompletableFuture（回调式）+ 新虚拟线程（“同步写法，异步性能”），
   后者正在吞掉前者的使用场景。

## 扩展方向

- 给 fast 任务加**取消**：Rust JoinHandle::abort、Go context.Cancel、TS AbortController——取消语义大不同。
- 加**超时**：`orElse`/select/timeout 机制对比。
- 对比背压（backpressure）：响应式流（RxJava/Reactor）在矩阵中的位置。

## 运行方式

见根目录 [README.md](../../README.md#快速开始)。C++ 走 `build-and-run.bat`，其余直接跑。
