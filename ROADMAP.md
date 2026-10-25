# ROADMAP · 动态优化改进计划

> 本文件是项目的“活计划”：每次开发、校验、评审后更新状态。
> 状态图例：✅ 完成/通过　🚧 进行中　⏳ 排队　❌ 受阻　⏭️ 缺工具链跳过

最后更新：2026-10-25（每次开发、校验后更新）

---

## 一、Demo 运行状态表

由 `npm test` 一键校验；每次改动 demo 后应重新运行并更新下表。严格全量验收使用 `npm run test:all`。

**当前校验结果：58 passed, 0 failed, 13 skipped, 71 total（2026-10-25）**——Python 12 项、TypeScript 11 项、Go 12 项、Rust 12 项、普通 Java 11 项通过；C++ 12 项及依赖 C++ 的 JNI Java 1 项因缺少 VS Build Tools 跳过。

| 主题 | Python | TypeScript | Go | Rust | C++ | Java |
|---|---|---|---|---|---|---|
| 01 泛型 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 02 并发模型 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 03 模式匹配 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 04 错误处理 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 05 所有权与内存 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 06 迭代器与流 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 07 宏与元编程 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 08 类型系统 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 09 FFI 与互操作 | ✅ | N/A¹ | ✅ | ✅ | ⏭️ | ⏭️ |
| 10 资源管理 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 11 模块与封装 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |
| 12 异步进阶 | ✅ | ✅ | ✅ | ✅ | ⏭️ | ✅ |

¹ 主题 09 的 TypeScript 列是**有意留白**（JS 无内建 FFI，见该主题 typescript/README.md）。

---

## 二、改进项清单

### 🔴 高优先级

| # | 事项 | 状态 | 备注 |
|---|---|---|---|
| R1 | 恢复 VS Build Tools，打通 C++ 与 JNI 示例 | 🚧 | Go/Rust 已恢复；Clang 已安装但缺 Windows C++ 标准库，不能直接替代 |
| R2 | 用 `run-all.ps1` 全量校验六语言输出逐字节一致 | 🚧 | 2026-10-25：58 passed / 13 skipped；严格模式已验证，恢复 C++ 后再冲刺 71 项全通过 |
| R3 | 建每日定时任务：自动运行 `run-all.ps1`，把结果回写本表 | ❎ 不采纳 | 2026-10-23 亲决定：维持手动校验（改完代码跑 `run-all.ps1` 并回填本表即可） |

### 🟡 中优先级（内容扩展）

| # | 事项 | 状态 | 备注 |
|---|---|---|---|
| C1 | 主题 02：并发模型（goroutine / async-await / tokio / 线程池） | ✅ | 2026-10-23 完成，5 语言实跑验证 |
| C2 | 主题 03：模式匹配（match / switch / match-case） | ✅ | 2026-10-23 完成；C++、Go、TS 展示“无此特性”的替代写法 |
| C3 | 主题 04：错误处理（Result / error / try-catch / 异常） | ✅ | 2026-10-23 完成，两大阵营对比 |
| C4 | 主题 05：所有权与内存（Rust 主打，C++ RAII 对比） | ✅ | 2026-10-23 完成，GC 语言三档确定性清理原语 |
| C5 | 主题 06–08：迭代器与流、宏与元编程、类型系统 | ✅ | 2026-10-23 全部完成；06 用 C++20 ranges |
| C6 | 新主题候选池：空值处理（Option/null/NaN）、字符串与编码 | ⏳ | 12 主题矩阵已填满，按学习反馈挑选 |
| C7 | 矩阵扩列：全主题补 Java | ✅ | 2026-10-23 完成：8 个既有主题各补 Java demo（JDK 21 便携版装于 E:\jdk-21） |
| C8 | 主题 09 FFI 与互操作 | ✅ | 2026-10-23 完成：五套机制调 C 的 strlen；Java 走 JNI 五步全手工；TS 有意留白 |
| C9 | 主题 10 资源管理（GC vs 非 GC 资源观） | ✅ | 2026-10-23 完成：缓冲区池练习，六语言输出一致 |
| C10 | 主题 11 模块与封装（六语言可见性机制） | ✅ | 2026-10-23 完成 |
| C11 | 主题 12 异步进阶（完成竞赛 + 汇合） | ✅ | 2026-10-23 完成：tokio 离线编译，六语言输出一致 |

### 🟢 低优先级（体验优化）

| # | 事项 | 状态 | 备注 |
|---|---|---|---|
| U1 | UI 页加入「浏览器内真跑」区：TS 直接执行，Python 用 Pyodide 转 WASM | ⏳ | 需要引入 CDN 依赖，与“零依赖”权衡后做 |
| U2 | 统一各语言代码高亮：目前 UI 是手工标注，考虑换成 highlight.js 本地版 | ⏳ | |
| U3 | 深色/浅色主题切换 | ⏳ | |
| U4 | 根目录 `index.html` 导航首页，串起所有主题 UI | ✅ | 2026-10-23 完成，并配 `server.js` + `npm run dev` 静态预览（Kimi 分配真实端口） |
| U5 | 主题 01 改造为六语言可编辑实验页：编辑源码、点击运行、显示编译错误与实际输出 | ⏳ 已评估，暂不实施 | 2026-10-25 方案评审：适合作为跨主题样板；MVP 采用本机受信任运行服务，五语言可用、C++ 缺工具链时明确不可用。要求构建/运行分阶段、固定语言适配器与参数、独立临时目录、超时/输出/并发限制、进程树终止、禁止联网拉依赖；初始源码以真实示例为单一事实源，TS 类型错误需 `tsc --noEmit`。公网开放必须另用容器/VM 沙箱，不得直接暴露本机执行接口 |
| U6 | GitHub Pages 主站 + WordPress 入口页 | ✅ 本地改造完成，待远程发布 | 2026-10-25 完成子路径兼容、`.nojekyll`、Pages Actions 与 WordPress iframe 模板；模拟验证 14 页面、14 份 Markdown、27 个站内链接通过 |

---

## 三、已知问题

| # | 问题 | 影响 | 处置 |
|---|---|---|---|
| K1 | ~~本机 Git Bash 的 `link.exe`（GNU coreutils）会遮蔽 MSVC 链接器~~ 已解决 | Rust msvc 链接 | C++ 构建由 `scripts\setup-msvc.bat` 自动发现并初始化 MSVC，不再写死 VC Tools bin |
| K2 | 项目路径含中文（当前为 `E:\liujh\语言特性学习`），个别老工具链对非 ASCII 路径敏感 | 潜在编码问题 | C++ 编译已加 `/utf-8`；批处理一律用 `%~dp0` 相对路径规避 |
| K3 | Rust GNU 工具链下载曾受网络波动中断 | 历史安装问题 | 当前便携 Rust 已安装成功；默认 gnullvm，主题 02、04 使用 GNU，均无需 MSVC |
| K4 | PowerShell 5.1 无 BOM 时按 ANSI 读脚本、向 cmd 传参用 GBK 编码 | 中文路径下 `cmd /c cd /d ...` 失败 | 项目约定：`.ps1` 必须带 UTF-8 BOM + CRLF；传给 cmd 的参数只用 ASCII 相对路径 |
| K5 | 本机无管理员权限：winget/msiexec 装 JDK 静默失败（MSI 1620/预检错误） | JDK 安装受限 | 当前通过 `toolchains.local.json` 使用 Android Studio 自带 JDK 25；也支持 `JAVA_HOME` 或 `PATH` |
| K6 | crates.io 网络间歇性不可达 | cargo 在线拉依赖超时 | `run-all.ps1` 统一 `cargo --offline`；依赖已缓存进项目内 `.toolchains\cargo\registry` |
| K7 | C 源码含中文注释时，cl 按 GBK 读文件会把 `#include` 吞进注释行（C4819） | JNI 的 .c 编译报一堆 C2143 | 凡含中文注释的源文件，cl 一律加 `/utf-8` |
| K8 | PowerShell 5.1 会把 `-Djava.library.path=.` 拆错，java 报“找不到主类 .library.path=.” | JNI 运行失败 | java 的 -D 参数必须加引号：`java "-Djava.library.path=." ...` |
| K9 | 本机 Windows 拒绝部分新生成的 Go 1.27.3 / Rust gnullvm 可执行文件（os error 5） | 特定示例无法启动 | Go 改用官方 1.26.10；Rust 主题 02、04 固定 GNU 目标，其余使用 gnullvm，全量实跑通过 |

---

## 四、更新日志

- **2026-10-23** 项目重建：删除旧项目，按“主题矩阵 + 统一演示形态”重建；主题 01 泛型五语言代码完成，Python/TS/Go 已实跑验证；Go 1.27、Rust 1.99（msvc）已安装；VS Build Tools 安装中。
- **2026-10-23（当日续）** 工具链全部打通：VS Build Tools 2022 装于 E:\VSBuildTools（C 盘仅 5.7GB 触发了 6.9GB 预检失败，改到 E 盘解决）；C++（cl 14.44）、Rust（msvc）实跑通过；`run-all.ps1` 修复了 PS5.1 编码/换行/路径三处坑后全量校验 **5 passed, 0 failed**。新增问题记录 K4 作为项目约定。
- **2026-10-23（主题 02）** 主题 02「并发模型」完成：同一道题（4 worker + 汇合点）在 goroutine / thread+mpsc / std::async / ThreadPoolExecutor / Promise.all 五模型下实现，文档 + UI + 代码齐备；`run-all.ps1` 重构为多主题批量校验，全量 **10 passed, 0 failed**。
- **2026-10-23（主题 03–08 收官）** 一次完成六个主题：模式匹配、错误处理、所有权与内存、迭代器与流、宏与元编程、类型系统。30 份新代码全部实跑通过；踩坑两处并修复：批处理首行 `#` 注释被 cmd 当命令执行（改为 `rem`）、C++ `show()` 中 label 先于异常求值导致输出重复（先求值再打印）。全量校验 **40 passed, 0 failed**。矩阵 8 主题全部 ✅，内容扩展线 C1–C5 清零。
- **2026-10-23（预览修复）** 两次预览错乱根因：本机 Kimi 桌面进程（PID 12156）常驻监听 localhost:7100，为其他项目提供预览，字面访问 7100 看到的是别人的页面。处置：项目升级为正式可预览应用——新增 `server.js`（零依赖静态服务器，支持 `--host/--port`）+ `package.json`（`npm run dev`）+ 根目录 `index.html` 主题导航首页（U4 顺带完成），由 Kimi Work 打开预览卡时分配无冲突端口，不再与 7100 相撞。
- **2026-10-23（md 链接体验修复）** 首页和主题页直链 `.md` 文件，浏览器只显示原始文本。新增 `viewer.html`（零依赖 Markdown 查看器，支持标题/表格/代码/加粗/删除线/链接），md 保持唯一事实源；首页两个入口及 8 个主题页的“返回总索引”全部改走查看器。渲染函数已通过离线单测（README 1 表、ROADMAP 5 表、无残留原始管道符）。
- **2026-10-23（md 链接全量排查）** 项目新增主题 09–12（FFI、资源管理、模块封装、异步进阶，语言集含 Java）。排查结果：4 个新主题 UI 页的面包屑仍直链 `../../../README.md`，已修复；`viewer.html` 升级——文档内部的相对 `.md` 链接自动改走查看器、主题目录链接自动直达该主题 UI 页；全量离线验证 14 份 md 渲染后**零 raw-md 链接**。首页导航补齐 09–12 四个主题卡片（校验徽标注明 40 项校验仅覆盖主题 01–08）。
- **2026-10-23（Java 列 + 主题 09–12）** 矩阵扩为 12 主题 × 6 语言，全量校验 **71 passed, 0 failed**。① JDK 21 因无管理员权限装不上 MSI，改 aka.ms 便携 zip 解压至 `E:\jdk-21`（K5）；② 8 个既有主题全部补 Java demo（虚拟线程 / switch 模式匹配 / Stream / 反射代理等 Java 21 特性全部实跑）；③ 新建主题 09 FFI（五套机制调 strlen，Java 走 JNI 五步全手工，TS 有意留白）、10 资源管理（GC vs 非 GC 资源观）、11 模块与封装、12 异步进阶（tokio 离线编译）；④ 既有 8 个 UI 页全部加 Java Tab。新踩坑三处并记录为 K6/K7/K8：crates.io 间歇不可达（cargo 改 --offline）、cl 按 GBK 读中文注释吞掉 include 行（加 /utf-8）、PS 5.1 拆错 -D 参数（加引号）。
- **2026-10-25（工程化收尾）** 修复校验漏计：每项明确 PASS / FAIL / SKIP，强制校验 71 项总数，构建与运行日志分离，新增 `npm test` 和严格模式 `npm run test:all`；C++ / JNI 构建改为自动发现 MSVC、JDK，移除固定安装目录；锁定 `tsx@4.23.15` 并生成 `package-lock.json`；首页、README 与主题 01–08 的五语言遗留表述同步为六语言。当前实跑 **23 passed, 0 failed, 48 skipped, 71 total**。
- **2026-10-25（工具链排查与 Java 恢复）** 旧 Go/Rust/JDK/VS Build Tools 安装目录均已不存在；注册表中的 Visual Studio 记录为失效残留。发现 Android Studio 自带 JDK 25，通过本机 `toolchains.local.json` 接入，普通 Java 11 项全部恢复通过；LLVM Clang 23 已安装，但缺少 Windows C++ 标准库，实测无法编译 iostream 示例。`setup-msvc.bat` 补充系统目录回退。最新结果 **34 passed, 0 failed, 37 skipped, 71 total**。
- **2026-10-25（便携 Go/Rust 恢复）** 官方便携包校验 SHA-256 后安装至项目内 `.toolchains/`，未修改系统环境变量；Go 使用 1.26.10，Rust/Cargo 使用 1.99.1，crate 缓存与 Go 构建缓存均项目内化。Rust 默认 gnullvm，主题 02、04 针对本机 Windows 启动限制改用 GNU，均无需 MSVC。`npm test` 实跑 **58 passed, 0 failed, 13 skipped, 71 total**；`npm run test:all` 汇总相同并因预期跳过返回 1。剩余仅 C++ 12 项与 JNI Java 1 项。
- **2026-10-25（Pages 部署改造）** 主题页返回总索引和 Markdown 加载改为相对路径，兼容 GitHub 项目 Pages 与 WordPress 子目录；新增 `.nojekyll` 和 `.github/workflows/deploy-pages.yml`，README 增加发布步骤及 WordPress iframe 模板。模拟 `/<仓库名>/` 验证 14 个页面、14 份 Markdown、27 个站内链接通过。仅完成本地改造，尚未创建远程仓库或发布。
