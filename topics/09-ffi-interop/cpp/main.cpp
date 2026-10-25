// 主题 09：FFI 与互操作 —— C++ 版
// C++ 是 C 的近亲：extern "C" 关闭名字修饰（name mangling），
// 直接链接 C 标准库——五语言里最无感的 FFI。

#include <cstring>
#include <iostream>

int main() {
    // strlen 就是 C 标准库函数，拿来即用
    std::cout << "strlen(\"hello\") = " << std::strlen("hello") << "\n";
    std::cout << "strlen(\"modern languages\") = " << std::strlen("modern languages") << "\n";
    return 0;
}
