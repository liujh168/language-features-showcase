# TypeScript 与 FFI（本主题不设可运行 demo，原因如下）

Node.js 的 JavaScript 层**没有内建 FFI**。要在 TS/JS 里调 C 库，只有两条路：

1. **原生插件（N-API / node-gyp）**：写 C++ 绑定、用编译工具链构建成 `.node` 文件。
   我们项目的 C++ 工具链（cl）其实可以编，但这违背「零依赖、一键可跑」的 demo 约定
   （需要 node-gyp + 头文件 + 编译步骤，学习者环境要求陡增）。
2. **ffi-napi / koffi 等第三方库**：纯 JS 声明式调 DLL，体验接近 Python ctypes，
   但属于外部依赖（`npm install koffi`），同样超出零依赖约定。

**结论**：本主题 TS 列留空是有意的教学选择——它恰好说明了 JS 的设计定位：
通过 N-API 插件把 FFI 隔离在原生模块层，主语言保持纯、可移植、事件驱动。
想体验的话，装个 `koffi` 两行就能调 `strlen`：

```ts
import koffi from "koffi";
const ucrt = koffi.load("ucrtbase.dll");
const strlen = ucrt.func("size_t strlen(const char *s)");
console.log(strlen("hello")); // 5
```
