# 主题 08：类型系统 Type System

> 同一道题：Dog/Cat 多态（`speak()`）——这是“类型哲学”的终极对比题。
> 输出六个语言完全一致。交互展示页：[ui/index.html](ui/index.html)

## 题目

两个类型 Dog（woof）、Cat（meow），统一调用 `speak()` 打印叫声。

## 三种类型哲学

### 名义类型 + 显式继承（C++）

```cpp
struct Dog : Animal { ... };  // is-a 关系写死在继承链上
```

- 接口 = 抽象基类（纯虚函数），多态靠 vtable 动态分发；
- 类型身份由**声明**决定：不继承 Animal 就不是 Animal，哪怕方法一模一样。

### 结构化类型（Go / TS / Python 的鸭子类型）

```go
type Animal interface { Speak() string }  // 方法集匹配即满足，无需声明
```
```ts
interface Animal { speak(): string }      // 结构匹配即可，implements 可省
```
```python
# 什么都不用声明，有 speak() 方法就行
```

- 类型身份由**形状**决定：长得像就是。Go 叫“隐式接口”，TS 叫“结构化类型”，Python 叫鸭子类型——同一思想的三档强度。

### trait 系统（Rust）

```rust
trait Animal { fn speak(&self) -> &'static str; }
impl Animal for Dog { ... }   // 实现与类型定义分离
```

- 介于两者之间：显式实现（像名义），但给外部类型实现本地 trait 也允许（像结构化）；
- `&dyn Animal` 动态分发，`impl Animal` 泛型静态分发——一个 trait 两种分发，开发者自己选。

## 差异速览

| 维度 | C++ | Rust | Go | TS | Python |
|---|---|---|---|---|---|
| 类型哲学 | 名义 | trait（名义+结构化混合） | 结构化 | 结构化 | 鸭子（运行时） |
| 接口声明 | 抽象基类 | `trait` | `interface`（隐式满足） | `interface`（可显可隐） | 无（Protocol 仅检查器） |
| 分发 | vtable 动态 | dyn 动态 / 泛型静态 | 接口值动态 | 结构擦除后动态 | 属性查找动态 |
| 静态检查 | 强 | 最强（生命周期） | 强 | 强（类型层最强） | 弱（可补 mypy） |

## 输出

```
dog says: woof
cat says: meow
```
