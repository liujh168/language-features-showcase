# 主题 01：泛型 Generics

> 同一道题，六种写法：一个泛型「盒子」容器 + 一个「取首个元素」的泛型函数。
> 六个语言输出完全一致，便于把注意力放在**语法和类型系统的差异**上。
> 交互展示页：[ui/index.html](ui/index.html)

## 题目

1. 定义泛型容器 `Box<T>`：能装入任意类型的值，能取出，还能 `map` 变换成另一种类型；
2. 定义泛型函数 `first`：取列表第一个元素；
3. 输出四行结果（见各 main 文件）。

## 六语言对比

### C++（模板，编译期实例化）

```cpp
template <typename T>
class Box { /* ... */ };
```

- 泛型的鼻祖（1980s STL）。模板在**编译期**展开成具体代码，运行零开销；
- 最灵活也最不设防：没有统一的约束语法（概念 Concepts 是 C++20 才补上的）；
- `decltype` 可推导 lambda 返回值，模板元编程几乎是一门函数式语言。

### Go（1.18+ 后置泛型，约束式）

```go
type Box[T any] struct { value T }
```

- 类型参数放方括号 `[T any]`；`any` 即 `interface{}`；
- 用**约束（constraint）**精确描述类型集合，如 `comparable`、`~int | ~float64`；
- 设计哲学克制：刻意不支持模板元编程级别的泛型。

### Rust（trait bound，单态化）

```rust
struct MyBox<T> { value: T }
impl<T> MyBox<T> { fn map<U>(self, f: impl Fn(T) -> U) -> MyBox<U> { ... } }
```

- 约束 = **trait bound**（`T: Display`、`T: Copy`），编译器据此检查能力；
- 单态化（monomorphization）生成具体代码，零运行时开销，与 C++ 同思路但类型检查更严格；
- 注：标准库已有智能指针 `Box`，故示例命名为 `MyBox`。

### Python（鸭子类型 + 注解泛型）

```python
T = TypeVar("T")
class Box(Generic[T]): ...
```

- **运行时不检查类型**——泛型只是给类型检查器（mypy / pyright）看的注解；
- 代码本来就对任何类型成立（鸭子类型），`TypeVar` 让检查器帮你抓错误；
- `map` 直接收 `Callable`，最贴近“能跑就行”的动态哲学。

### TypeScript（编译期擦除）

```ts
class Box<T> { ... }
```

- 语法接近 C#/Java：`<T>` 声明，`extends` 约束（如 `T extends { length: number }`）；
- 泛型在**编译期擦除**，产物是普通 JS，运行时不携带类型信息；
- 兼具静态检查的安全和动态语言的轻量。

## 一图看懂差异

| 维度 | C++ | Go | Rust | Python | TypeScript |
|---|---|---|---|---|---|
| 引入年代 | 1980s | 2022 (1.18) | 2015 | 2015 (typing) | 2012 |
| 约束机制 | Concepts (C++20) | constraint 接口 | trait bound | 无（仅注解） | extends 子句 |
| 实现方式 | 编译期实例化 | 编译期实例化/字典 | 单态化 | 无（动态分发） | 编译期擦除 |
| 运行时开销 | 零 | 零/小 | 零 | 解释执行 | 零（类型消失） |
| 类型检查时机 | 编译期（滞后） | 编译期 | 编译期 | 静态检查器（可选） | 编译期（tsc） |

## 运行方式

见仓库根目录 [README.md](../../README.md#快速开始) 与各语言目录下的源码注释。
