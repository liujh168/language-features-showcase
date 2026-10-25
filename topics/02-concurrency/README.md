# 主题 02：并发模型 Concurrency

> 同一道题，六种写法：主线程启动 4 个并发 worker，各自干活，汇合后按序输出。
> 输出六个语言完全一致——差异全在**并发原语和调度模型**。
> 交互展示页：[ui/index.html](ui/index.html)

## 题目

1. 启动 4 个并发 worker，第 i 个返回 `(i, i*10)`；
2. 主线程在汇合点等全部完成；
3. 按 worker 编号排序后输出（并发完成顺序不确定，排序保证输出确定）。

## 六语言对比

### Go（goroutine + channel，招牌模型）

```go
go work(i, &wg, ch)   // go 关键字启动，栈仅几 KB
wg.Wait()             // WaitGroup 汇合
ch <- [2]int{i, ...}  // “通过通信共享内存”
```

- 运行时自带 M:N 调度器，goroutine 廉价到可以起几万个；
- channel 是一等公民，数据流向显式。

### Rust（std::thread + mpsc，编译期防数据竞争）

```rust
thread::spawn(move || work(i, tx))  // 1:1 系统线程
tx.send((i, v))                     // 所有权随消息转移
h.join().unwrap()                   // 汇合
```

- 线程更重（系统线程），但 `Send`/`Sync` trait 让数据竞争在**编译期**报错；
- 更大规模的 IO 并发用 tokio（async/await），本 demo 刻意用标准线程保持最小依赖。

### C++（std::async + std::future）

```cpp
auto f = std::async(std::launch::async, ...);  // 异步任务
f.get();                                        // 汇合并取结果
```

- C++11 才进入标准库；底层就是 std::thread 的封装；
- 自由但也危险：裸线程忘了 join、数据竞争都是运行时炸弹。

### Python（ThreadPoolExecutor，GIL 之下的并发）

```python
with ThreadPoolExecutor(max_workers=4) as pool:
    futures = [pool.submit(work, i) for i in range(1, 5)]
    results = [f.result() for f in futures]  # 汇合
```

- **GIL** 决定了线程不并行 CPU 计算，但 IO 等待时会释放，IO 密集任务依然并发有效；
- CPU 密集的正解是多进程（`ProcessPoolExecutor`）或 C 扩展。

### TypeScript（事件循环 + Promise，单线程的“并发”）

```ts
await Promise.all([1, 2, 3, 4].map(work))  // 汇合
```

- JS 只有一个主线程，“并发”是任务在事件循环上**交错**（interleaving），不是并行；
- await 挂起点即让出点——没有锁，也没有数据竞争（单线程！）。

## 差异速览

| 维度 | Go | Rust | C++ | Python | TypeScript |
|---|---|---|---|---|---|
| 基本单元 | goroutine（M:N 轻量） | 系统线程（1:1） | 系统线程 | 线程（GIL 限制） | 单线程事件循环 |
| 启动方式 | `go func()` | `thread::spawn` | `async`/`thread` | 线程池提交 | `async` 函数调用 |
| 汇合原语 | `WaitGroup`/`channel` | `join`/`channel` | `future.get()` | `future.result()` | `Promise.all` |
| 数据传递 | channel | channel（所有权转移） | 共享内存+锁 | 共享内存（GIL 兜底） | 消息传递天然无竞争 |
| 数据竞争防护 | channel 惯用法 + race detector | 编译期（Send/Sync） | 无（靠自己） | GIL（有限） | 单线程天然免疫 |
| 适用场景 | 高并发服务 | 系统级+安全并发 | 性能极致控制 | IO 密集/原型 | IO 密集的 I/O 服务 |

## 运行方式

见仓库根目录 [README.md](../../README.md#快速开始)。六个语言输出：

```
start 4 workers
result from worker 1: 10
result from worker 2: 20
result from worker 3: 30
result from worker 4: 40
all done
```
