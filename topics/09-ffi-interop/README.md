# 主题 09：FFI 与互操作

> 同一道题：从各语言里调用 **C 标准库的 `strlen`**。
> 五个语言五套机制，工程量从“一行”到“五步”——这是 FFI 最直观的对比。
> 交互展示页：[ui/index.html](ui/index.html)

## 题目

对 `"hello"` 和 `"modern languages"` 两个字符串，调用 C 的 `strlen` 求长度：

```
strlen("hello") = 5
strlen("modern languages") = 16
```

## 五语言机制对比

### C++（extern "C"，近亲调用）

`extern "C"` 关闭名字修饰，C 库直接链接，零额外工具。**最无感**。

### Rust（extern 块 + unsafe，一等公民 FFI）

`extern "C" { fn strlen(...) }` 声明，`unsafe` 块调用。零开销，编译器不替你担保安全。

### Python（ctypes，一行即调）

`ctypes.CDLL("ucrtbase.dll")` 直接加载系统 DLL，无需编译。**最适合胶水脚本**。

### Go（syscall.NewLazyDLL，Windows 直连）

纯 Go 调 DLL，不走 cgo（cgo 需要 gcc，且跨 C 边界失去调度优势）。**仅限 Windows**；跨平台调 C 库还是 cgo。

### Java（JNI，五步全手工）

`javac -h` 生成头文件 → 写 C 实现 → `cl` 编译成 `main.dll` → `System.loadLibrary` → 调 `native` 方法。
繁琐到催生了一代替代方案：JNA（运行时动态绑定）、Java 17 的 Foreign Function & Memory API（官方现代化答案）。

### TypeScript（本主题不适用，教学留白）

JS 没有内建 FFI，需 N-API 原生插件或 `koffi` 等第三方库——超出零依赖约定。
详见 [typescript/README.md](typescript/README.md)，这本身就是个设计结论。

## 工程启示

| 场景 | 首选 |
|---|---|
| 胶水脚本调系统 API | Python ctypes |
| 系统级语言接 C 库 | C++ / Rust extern |
| Java 生态调原生库 | FFM API（新）/ JNA，避免手写 JNI |
| 跨平台 Go 调 C | cgo（接受开销）或纯 Go 重写 |
| Node 调原生 | N-API 插件，隔离在原生层 |

## 运行方式

C++ / Java 需走 `build-and-run.bat`（含编译步骤），其余直接跑；见根目录 [README.md](../../README.md#快速开始)。
