// 主题 01：泛型 Generics —— C++ 版
// C++ 泛型的鼻祖：模板（template）。编译期实例化，零运行时开销。
// 也是五者中最“放飞”的：模板元编程几乎是一门函数式语言。

#include <iostream>
#include <string>
#include <vector>
#include <utility>

template <typename T>
class Box {
public:
    explicit Box(T value) : value_(std::move(value)) {}

    const T& get() const { return value_; }

    // map 接收任意可调用对象 f，返回值类型用 decltype 推导
    template <typename F>
    auto map(F f) const {
        return Box<decltype(f(value_))>(f(value_));
    }

private:
    T value_;
};

template <typename T>
T first(const std::vector<T>& items) { return items[0]; }

int main() {
    std::cout << "int box: " << Box(42).get() << '\n';
    std::cout << "str box: " << Box(std::string("hello")).get() << '\n';
    std::cout << "first of [10, 20, 30] = " << first(std::vector{10, 20, 30}) << '\n';
    std::cout << "doubled 21 -> " << Box(21).map([](int x) { return x * 2; }).get() << '\n';
    return 0;
}
