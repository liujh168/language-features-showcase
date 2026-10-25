# 现代编程语言功能演示库

> 学习/教育用途：同一道题，各主流语言各写一版，横向对比语言特性差异。
> 每个主题 = **文档**（讲解与对比）+ **代码**（可直接编译运行）+ **UI**（零依赖静态展示页）。

## 功能主题矩阵

| 主题 | C++ | Go | Rust | Python | TypeScript | Java | 文档 / UI |
|---|---|---|---|---|---|---|---|
| [01 泛型 Generics](topics/01-generics/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/01-generics/README.md) · [UI](topics/01-generics/ui/index.html) |
| [02 并发模型](topics/02-concurrency/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/02-concurrency/README.md) · [UI](topics/02-concurrency/ui/index.html) |
| [03 模式匹配](topics/03-pattern-matching/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/03-pattern-matching/README.md) · [UI](topics/03-pattern-matching/ui/index.html) |
| [04 错误处理](topics/04-error-handling/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/04-error-handling/README.md) · [UI](topics/04-error-handling/ui/index.html) |
| [05 所有权与内存](topics/05-ownership-memory/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/05-ownership-memory/README.md) · [UI](topics/05-ownership-memory/ui/index.html) |
| [06 迭代器与流](topics/06-iterators/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/06-iterators/README.md) · [UI](topics/06-iterators/ui/index.html) |
| [07 宏与元编程](topics/07-macros-metaprogramming/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/07-macros-metaprogramming/README.md) · [UI](topics/07-macros-metaprogramming/ui/index.html) |
| [08 类型系统](topics/08-type-system/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/08-type-system/README.md) · [UI](topics/08-type-system/ui/index.html) |
| [09 FFI 与互操作](topics/09-ffi-interop/) | ✅ | ✅ | ✅ | ✅ | N/A¹ | ✅ | [文档](topics/09-ffi-interop/README.md) · [UI](topics/09-ffi-interop/ui/index.html) |
| [10 资源管理](topics/10-resource-management/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/10-resource-management/README.md) · [UI](topics/10-resource-management/ui/index.html) |
| [11 模块与封装](topics/11-modules-encapsulation/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/11-modules-encapsulation/README.md) · [UI](topics/11-modules-encapsulation/ui/index.html) |
| [12 异步进阶](topics/12-async-advanced/) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [文档](topics/12-async-advanced/README.md) · [UI](topics/12-async-advanced/ui/index.html) |

代码均已实现。当前环境校验结果（2026-10-25）：**58 passed, 0 failed, 13 skipped, 71 total**；Python 12 项、TypeScript 11 项、Go 12 项、Rust 12 项、普通 Java 11 项通过，C++ 12 项及依赖 C++ 的 JNI Java 1 项因缺少 VS Build Tools 而明确跳过。历史全工具链验证记录见 [ROADMAP.md](ROADMAP.md)。
¹ 主题 09 的 TypeScript 列是**有意留白**：JS 无内建 FFI（需 N-API 插件），见 [typescript/README.md](topics/09-ffi-interop/typescript/README.md)

## 目录结构

```
语言特性学习\
├── README.md               ← 本文件：总索引
├── ROADMAP.md              ← 动态优化改进计划
├── index.html              ← 主题导航首页（可预览）
├── viewer.html             ← 零依赖 Markdown 查看器（阅读各主题 README）
├── server.js               ← 零依赖静态服务器（npm run dev，供预览卡使用）
├── package.json            ← 预览、测试入口与锁定的 TS 依赖
├── scripts/
│   ├── run-all.ps1         ← 一键编译运行全部 demo 并校验输出
│   └── setup-msvc.bat      ← 自动发现本机 MSVC 构建环境
└── topics/
    ├── 01-generics/          ← 泛型：模板 / [T any] / trait bound / 鸭子类型 / 类型擦除 / 擦除
    ├── 02-concurrency/       ← 并发：goroutine / thread+mpsc / async+futures / 线程池 / 事件循环 / 虚拟线程
    ├── 03-pattern-matching/  ← 模式匹配：match / switch / match-case（C++、Go、TS 无，展示替代写法）/ Java 21 switch
    ├── 04-error-handling/    ← 错误处理：Result / (T,error) / 异常 / 异常 / 异常 / 异常
    ├── 05-ownership-memory/  ← 所有权与内存：RAII / Drop / defer / with / try-finally / try-with-resources
    ├── 06-iterators/         ← 迭代器与流：惰性管道 vs 显式循环（C++20 ranges / 生成器 / Stream）
    ├── 07-macros-metaprogramming/ ← 宏与元编程：文本宏 / 无 / token 树宏 / 装饰器 / 无 / 反射代理
    ├── 08-type-system/       ← 类型系统：名义 vs 结构化 vs 鸭子类型
    ├── 09-ffi-interop/       ← FFI：extern "C" / syscall.DLL / extern块+unsafe / ctypes / N/A / JNI
    ├── 10-resource-management/ ← 资源管理：GC 语言 vs 非 GC 的资源归还观（缓冲区池练习）
    ├── 11-modules-encapsulation/ ← 模块与封装：六种可见性机制对比
    └── 12-async-advanced/    ← 异步进阶：三任务完成竞赛（tokio / asyncio / Promise.all / CF / channel）
```

每个主题目录内部结构统一：`README.md`（讲解）+ `ui/index.html`（展示页）+ 各语言子目录 `cpp/` `go/` `rust/` `python/` `typescript/` `java/`（C++ 与主题 09 的 Java/JNI 附 `build.bat` / `build-and-run.bat`）。

## 快速开始

要求：`python`（3.10+）、`node` + `npx`、`go`（1.21+）、`cargo`（Rust，离线模式）、JDK 21+、VS Build Tools 2022。工具从 `PATH`、`JAVA_HOME` 或 Visual Studio 安装信息自动发现，不在脚本中绑定固定安装目录。

本机可在根目录 `toolchains.local.json` 中配置 JDK 与项目内便携 Go/Rust（该文件和 `.toolchains/` 均已加入 `.gitignore`，`JAVA_HOME` 环境变量优先）：

```json
{
  "javaHome": "E:\\Android\\studio\\as\\jbr",
  "goHome": ".toolchains/go1.26/go",
  "cargoHome": ".toolchains/cargo",
  "rustupHome": ".toolchains/rustup"
}
```

当前便携版本为 Go 1.26.10、Rust/Cargo 1.99.1；Rust 默认使用无需 MSVC 的 gnullvm 目标，主题 02、04 按本机兼容性使用 GNU 目标。Go 缓存和临时目录均位于项目内。

```powershell
# 首次安装锁定的 TypeScript 依赖
npm install

# 校验全部 71 项；缺工具链时明确记为 skipped
npm test

# 严格模式：存在 failed 或 skipped 都返回非零退出码
npm run test:all

# 启动静态预览
npm run dev

# 或单独运行某一语言
cd topics/01-generics/python && python main.py
cd topics/01-generics/typescript && npx --no-install tsx main.ts
cd topics/01-generics/go && go run main.go
cd topics/01-generics/rust && cargo run --offline --quiet
cd topics/01-generics/java && javac -encoding UTF-8 Main.java && java Main
cd topics/01-generics/cpp && .\build-and-run.bat   # Windows/MSVC；其他平台用 g++ -std=c++17 main.cpp
```

同一主题内，所有语言的输出**逐字节一致**——差异全在语法与机制，输出无关噪音被刻意消除（排序、固定文案）。

## 部署到 GitHub Pages 并接入 WordPress

项目是纯静态网站，Pages 不需要运行 `server.js`、安装 npm 依赖或编译六语言示例。仓库已包含 `.nojekyll`（保留原始 Markdown 文件）和 `.github/workflows/deploy-pages.yml`（自动发布）；页面与文档链接均兼容 `/<仓库名>/` 子路径。

1. 公开仓库：`https://github.com/liujh168/language-features-showcase`。
2. Pages 已选择 **GitHub Actions**，推送到 `main` 会自动发布，也可在 Actions 中手动运行 **Deploy static site to GitHub Pages**。
3. 当前线上地址：`https://code.liujh168.com/language-features-showcase/`；标准地址 `https://liujh168.github.io/language-features-showcase/` 会跳转到该自定义域名。

在 WordPress 中新增页面，使用“自定义 HTML”区块嵌入以下入口即可。若站点不允许 iframe，可只保留新窗口链接。

```html
<div style="position:relative;width:100%;min-height:720px;">
  <iframe
    src="https://code.liujh168.com/language-features-showcase/"
    title="现代编程语言功能演示库"
    style="position:absolute;inset:0;width:100%;height:100%;border:0;"
    loading="lazy">
  </iframe>
</div>
<p><a href="https://code.liujh168.com/language-features-showcase/" target="_blank" rel="noopener">在新窗口打开语言特性演示库</a></p>
```

Pages 仅发布静态展示功能；ROADMAP 中规划的六语言代码执行实验页不得直接暴露为公网执行接口。

## 如何扩展

**新增一个主题**：在 `topics/` 下建 `13-xxx/` 目录，复制任一主题的形态（README.md + ui/index.html + 各语言子目录），在 `run-all.ps1` 登记期望输出和 demo 命令，然后在上方矩阵表登记一行。

**新增一门语言**：在每个主题目录下加 `kotlin/`、`csharp/` 等子目录，UI 页加一个 Tab，矩阵表加一列，`run-all.ps1` 的 `Default-Demos` 里登记构建/运行命令。

改进计划与当前状态见 [ROADMAP.md](ROADMAP.md)。
