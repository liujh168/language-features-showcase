// 主题 07：宏与元编程 —— C++ 版
// C++ 有两代元编程：
//  1. 预处理器宏（#define）——文本替换，最早也最危险（无类型、无作用域、
//     经典坑 SQUARE(a+b) 展开成 a+b*a+b；
//  2. 模板 + constexpr——图灵完备的编译期计算（现代正道）。
// 本例两者都展示。

#include <iostream>

// 宏：必须给参数加括号，否则优先级坑死你
#define SQUARE(x) ((x) * (x))

// constexpr 函数：编译期可求值，有类型检查，可调试
constexpr int cube(int x) { return x * x * x; }

static_assert(cube(3) == 27, "cube must be computable at compile time");

int main() {
    std::cout << "square(7) = " << SQUARE(7) << "\n";
    std::cout << "cube(3) = " << cube(3) << "\n";
    return 0;
}
