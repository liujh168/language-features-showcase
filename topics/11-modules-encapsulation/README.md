# 主题 11：模块与封装

> 同一道题：实现一个 `utils` 工具模块——公开 `greet()`、`area()`、`makeUser()`，
> 隐藏内部实现细节。输出六个语言完全一致，差异全在**可见性机制**。
> 交互展示页：[ui/index.html](ui/index.html)

## 题目

```
utils.greet() = hello from utils
area(3, 4) = 12
makeUser("ada") = User(name=ada)
```

其中 `decorate()`（给字符串加后缀）是私有实现，`User` 的内部字段外部不可直接访问。

## 六语言可见性机制对比

| 语言 | “私有”怎么表达 | 默认可见性 | 模块边界单位 |
|---|---|---|---|
| C++ | anonymous namespace / `static` / `class private` | public（struct 成员） | 翻译单元（.cpp 文件） |
| Go | **首字母小写**（无关键字） | 私有 | package |
| Rust | `mod` + `pub` 标记 | **私有**（默认隐藏） | module（mod 树） |
| Python | `_下划线` 约定 + `__all__` | 公开 | .py 文件 |
| Java | `private` / 包私有（默认） | 包私有 | package / JPMS 模块 |
| TypeScript | `private`（编译期）/ `#`（运行期原生） | public | ES Module 文件 |

## 设计哲学差异

- **Go 最极简**：可见性压缩成大小写一个维度，读代码即知边界。
- **Rust 最保守**：默认私有、显式公开，与 Go 相反——大型工程防误用。
- **Java/C# 名义可见性**：四级访问控制，配合 package/assembly 两层边界。
- **Python 靠约定**：`_` 是社区的“君子协定”，强制力来自 review 和类型检查器——动态语言的典型风格。
- **C++ 靠链接器**：匿名命名空间的符号干脆不进符号表，“私有”是物理级的。

## 包管理一句话（扩展话题）

模块的“对外发布”还有第二半：包管理器——cargo / go modules / npm / pip / vcpkg / Maven。
它们的版本语义、依赖解析、锁文件设计差异巨大，值得单独开题（见 ROADMAP）。

## 运行方式

见根目录 [README.md](../../README.md#快速开始)。
