// 主题 08：类型系统 —— C++ 版
// 名义类型（nominal）：继承链显式声明 is-a 关系。
// 多态靠虚函数 + vtable 动态分发；unique_ptr 管理对象生命周期。
// C++20 起 Concepts 让“接口约束”也能表达，但运行时多态仍是虚函数当家。

#include <iostream>
#include <memory>
#include <string>
#include <utility>
#include <vector>

struct Animal {                      // 抽象基类 = 接口
    virtual std::string speak() const = 0;  // 纯虚函数
    virtual ~Animal() = default;
};

struct Dog : Animal {
    std::string speak() const override { return "woof"; }
};

struct Cat : Animal {
    std::string speak() const override { return "meow"; }
};

int main() {
    std::vector<std::pair<std::string, std::unique_ptr<Animal>>> animals;
    animals.emplace_back("dog", std::make_unique<Dog>());
    animals.emplace_back("cat", std::make_unique<Cat>());

    for (const auto& [name, a] : animals) {
        std::cout << name << " says: " << a->speak() << "\n";
    }
    return 0;
}
