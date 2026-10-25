# 主题 04：错误处理 Error Handling

> 同一道题：解析正整数 + 安全除法，成功失败各演示一次——六种语言的错误哲学正面对撞。
> 输出六个语言完全一致。交互展示页：[ui/index.html](ui/index.html)

## 题目

- `parse_positive("42")` → 42；`parse_positive("abc")` → 失败（invalid digit）
- `div(10, 2)` → 5；`div(10, 0)` → 失败（division by zero）

## 两大阵营

### “错误是值”派（Rust / Go）

```rust
fn parse_positive(s: &str) -> Result<i32, String>   // 失败可能写在签名上
```
```go
func parsePositive(s string) (int, error)           // 调用方必须处理 err
```

- 可能的失败是**类型签名的一部分**，编译器/调用方无法无视；
- Rust 的 `?` 运算符和 Go 的 `if err != nil` 是各自生态的标准姿势。

### “错误是控制流”派（C++ / Python / TS）

```python
raise ValueError("invalid digit")     # try/except 捕获
```
```cpp
throw std::runtime_error("...");      // try/catch 捕获
```

- 异常可以穿透任意层调用栈，写起来爽；
- 代价：失败**不在函数签名上**，调用方不看实现就不知道会抛什么。

## 差异速览

| 维度 | Rust | Go | C++ | Python | TypeScript |
|---|---|---|---|---|---|
| 机制 | Result<T,E> | (T, error) | throw/catch | raise/except | throw/try-catch |
| 失败可见性 | 签名上 | 签名上 | 签名上看不出 | 看不出 | 看不出 |
| 强制处理 | 编译期 | 惯例（vet 辅助） | 否 | 否 | 否 |
| 零成本抽象 | ✅（无异常路径零开销） | ✅ | ❌（异常有运行时成本） | ❌ | ❌ |

## 教学要点

1. **Go 的 if err != nil 被群嘲但有效**：显式、无魔法；Rust 证明“错误是值”也能优雅（`?` 传播）。
2. **C++ 的现代趋势是回归“错误是值”**：`std::expected`（C++23）就是 Rust `Result` 的表亲。
3. **Python/TS 的异常适合“真异常”场景**，把可预期失败全用异常处理会让控制流隐式化。

## 输出

```
parse "42" -> 42
parse "abc" -> error: invalid digit
10 / 2 = 5
10 / 0 -> error: division by zero
```
