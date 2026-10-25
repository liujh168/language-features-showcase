// 主题 03：模式匹配 —— C++ 版
// C++ 至今（C++23/26）没有进入标准的模式匹配——这是编译器厂商和委员会
// 长期拉锯的提案（P1371 等）。现实代码就是 if-else 链 + switch。
// 本例故意写成和 Rust 版一一对应，方便对比“缺了什么”。

#include <iostream>
#include <string_view>

std::string_view classify(int n) {
    if (n == 0) return "zero";
    if (n == 1) return "one";
    if (n < 0) return "negative";
    if (n % 2 == 0) return "even";
    return "odd";  // 兜底；编译器不检查穷尽性，全靠程序员自觉
}

int main() {
    for (int n : {0, 1, -3, 42, 7}) {
        std::cout << "classify(" << n << ") = " << classify(n) << "\n";
    }
    return 0;
}
