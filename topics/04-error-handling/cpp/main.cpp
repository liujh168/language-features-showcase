// 主题 04：错误处理 —— C++ 版
// 异常机制（try/catch/throw）1980s 的老设计：错误与控制流耦合，
// 且不在函数签名上声明——调用方无从知道 parsePositive 会抛。
// 现代 C++ 趋势：错误码 / std::expected（C++23）回归“错误是值”。

#include <iostream>
#include <stdexcept>
#include <string>

int parsePositive(const std::string& s) {
    try {
        size_t pos = 0;
        int v = std::stoi(s, &pos);
        if (pos != s.size()) throw std::runtime_error("invalid digit");
        return v;
    } catch (const std::invalid_argument&) {
        throw std::runtime_error("invalid digit");
    }
}

int divSafe(int a, int b) {
    if (b == 0) throw std::runtime_error("division by zero");
    return a / b;
}

template <typename F>
void show(const char* label, F&& f) {
    try {
        auto v = f();  // 先求值，再输出——否则异常会先打出半个标签
        std::cout << label << v << "\n";
    } catch (const std::runtime_error& e) {
        std::cout << label << "error: " << e.what() << "\n";
    }
}

int main() {
    show("parse \"42\" -> ", [] { return std::to_string(parsePositive("42")); });
    show("parse \"abc\" -> ", [] { return std::to_string(parsePositive("abc")); });
    show("10 / 2 = ", [] { return std::to_string(divSafe(10, 2)); });
    show("10 / 0 -> ", [] { return std::to_string(divSafe(10, 0)); });
    return 0;
}
