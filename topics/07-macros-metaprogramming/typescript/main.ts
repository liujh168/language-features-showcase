// 主题 07：宏与元编程 —— TypeScript 版
// TS 没有宏（也不该有——宏与类型系统天生相克）。
// 它的“元编程”层次：泛型 + 条件/映射类型（编译期类型计算）、
// 装饰器（实验性）。运行期只是普通函数调用。

const square = (x: number): number => x * x;
const cube = (x: number): number => x * x * x;

// TS 真正的“元编程”在类型层面，例如编译期算平方的类型体操：
// type Square<N extends number> = ... （留给读者，见 ROADMAP 扩展项）

console.log("square(7) =", square(7));
console.log("cube(3) =", cube(3));
