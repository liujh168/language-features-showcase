// 主题 05：所有权与内存 —— C++ 版
// RAII（Resource Acquisition Is Initialization）：资源生命周期绑定对象生命周期，
// 析构函数在作用域出口自动执行——这是 C++ 最重要的惯用法，也是 Rust 所有权的灵感来源。
// 区别：C++ 靠程序员自觉（拷贝会复制资源句柄），Rust 在类型系统层面强制。

#include <iostream>

class Resource {
public:
    explicit Resource(int id) : id_(id) {
        std::cout << "acquire resource #" << id_ << "\n";
    }
    ~Resource() {  // 析构函数 = 确定性清理点
        std::cout << "release resource #" << id_ << "\n";
    }
    // 真实代码还要处理拷贝/移动（unique_ptr 已替你做好）
private:
    int id_;
};

void useIt() {
    Resource r(1);  // 栈对象：离开作用域必然析构
    std::cout << "use resource #1\n";
}  // <- ~Resource() 在这里执行

int main() {
    useIt();
    std::cout << "done\n";
    return 0;
}
