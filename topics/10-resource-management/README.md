# 主题 10：资源管理与内存模型

> 同一道题：向缓冲区池申请 A、B 两个缓冲区，用完归还。
> 表面上是“池模式”练习，实质是 **GC 语言 vs 非 GC 语言资源观** 的对照实验。
> 交互展示页：[ui/index.html](ui/index.html)

## 题目

```
allocate buffer A
allocate buffer B
use A + B
return A to pool
return B to pool
all buffers back in pool
```

## 为什么用这个题目

“GC 什么时候回收内存”是**无法写出确定输出**的（这正是 GC 的本质），所以本主题换个更贴近工程的角度：

**GC 管内存，但管不了“资源”**。连接、句柄、锁、缓冲区——所有稀缺资源在任何语言里都必须显式归还。

| 语言 | 内存模型 | 资源归还机制 | 确定性 |
|---|---|---|---|
| C++ | 手动 + RAII | 析构函数（作用域结束自动调） | 完全确定 |
| Rust | 所有权 + Drop | Drop trait（离开作用域自动调） | 完全确定 |
| Python | 引用计数 + 循环 GC | `with` / `close()`（约定 + 协议） | 代码确定 |
| Go | tracing GC | `Close()` / `sync.Pool`（靠自觉） | 代码确定 |
| Java | tracing GC | `try-with-resources` / `close()` | 代码确定 |
| TypeScript | tracing GC | `dispose()` / `using`（ES 新提案） | 代码确定 |

## 各语言要点

- **C++**：RAII 是“资源获取即初始化”——构造函数拿资源，析构函数放资源，编译器保证调用。
- **Rust**：所有权系统在编译期插入 `drop` 调用，无 GC 也无泄漏（安全子集内）。
- **Python**：`__del__` 时机不可靠（循环引用要等 GC），所以池化资源一律 `with`。
- **Go/Java/TS**：finalizer（`finalize`/`SetFinalizer`/`FinalizationRegistry`）都不保证时机——只用于兜底，不用于业务。

## 扩展思考

1. 为什么 C++/Rust 不需要 `close()` 方法也能管好资源？
2. Java 的 `Cleaner`、Go 的 `runtime.SetFinalizer` 为什么不能替代 `close()`？
3. `sync.Pool` 的缓存对象随时可能被 GC 收走，这决定了它能用来做什么、不能做什么？

## 运行方式

见根目录 [README.md](../../README.md#快速开始)。
