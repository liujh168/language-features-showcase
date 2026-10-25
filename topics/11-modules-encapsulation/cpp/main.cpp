// 主题 11：模块与封装 —— C++ 版
// C++ 的可见性靠三件套：namespace（防名字冲突）、anonymous namespace /
// static（文件级私有，等效 C 的 static 函数）、class private。
// 头文件 + 链接模型是模块系统的“史前遗产”，C++20 才有官方 modules。

#include <iostream>
#include <string>

namespace utils {

// 匿名命名空间 = 仅本翻译单元可见（“模块私有”）
namespace {
    std::string decorate(const std::string& s) {
        return s + " from utils"; // 内部实现细节，对外不可见
    }
}

// 公开 API
std::string greet() { return decorate("hello"); }

int area(int w, int h) { return w * h; }

class User {
public:
    User(std::string name) : name_(std::move(name)) {}
    // 友元函数：让 << 能访问私有成员，同时保持字段封装
    friend std::ostream& operator<<(std::ostream& os, const User& u) {
        return os << "User(name=" << u.name_ << ")";
    }
private:
    std::string name_; // private：外部只能通过公开接口访问
};

User makeUser(const std::string& name) { return User(name); }

} // namespace utils

int main() {
    std::cout << "utils.greet() = " << utils::greet() << "\n";
    std::cout << "area(3, 4) = " << utils::area(3, 4) << "\n";
    std::cout << "makeUser(\"ada\") = " << utils::makeUser("ada") << "\n";
    return 0;
}
