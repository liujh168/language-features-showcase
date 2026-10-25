# 主题 05：所有权与内存 Ownership & Memory

> 同一道题：资源的生命周期管理——获取、使用、确定性释放。
> 这是唯一一个六语言答案**本质不同**的主题（也是教学价值最高的）。
> 输出六个语言一致。交互展示页：[ui/index.html](ui/index.html)

## 题目

资源对象：创建即 "acquire resource #1"，使用，**离开作用域时必定** "release resource #1"，最后打印 "done"。

## 六语言本质是三种内存哲学

### 手动/编译期管理（C++ / Rust）—— 确定性释放

- **C++ RAII**：析构函数绑定作用域，`}` 就是释放点。释放时机 100% 确定，但**正确性靠程序员自觉**——忘了处理拷贝就是 double free。
- **Rust 所有权**：RAII 同款释放时机，但编译器强制规则——一个值只有一个所有者，赋值即移动（move），double free 在编译期就是错误。

### GC + 确定性清理原语（Go / Python / TS）

内存本身交给垃圾回收器，但“释放时机”可以用语言原语保证：

| 语言 | 原语 | 释放时机 |
|---|---|---|
| Go | `defer release()` | 函数退出时（LIFO） |
| Python | `with` 上下文管理器 | with 块结束（无论是否异常） |
| TS/JS | `try-finally` | finally 块（手动调用 close） |

注意三者的共同点和区别：Go 的 defer 在**函数级**作用域；Python 的 with 是**任意块级**作用域且语法最干净；JS 最原始——全靠手写。

## 教学要点

1. **GC 不等于“释放不可控”**：文件句柄、锁、连接这些资源不该等 GC，六种语言都有确定性清理机制。
2. **Rust 的所有权 = RAII + 编译期强制**：`Drop` trait 就是析构函数，但 `move` 语义消灭了 C++ 的拷贝陷阱。
3. **TS 的 `finally` 是 RAII 的手动模拟**——JS 没有析构函数，这背后是“对象何时死亡由 GC 决定，语言拒绝承诺”的设计。

## 输出

```
acquire resource #1
use resource #1
release resource #1
done
```
