// 主题 06：迭代器与流 —— C++ 版
// C++20 Ranges：视图（views）是惰性管道，可无限组合，
// 思路与 Rust 迭代器完全一致（filter/map/take），
// 编译用 /std:c++20。

#include <iostream>
#include <numeric>
#include <ranges>
#include <vector>

namespace views = std::ranges::views;

int main() {
    // 管道只描述计算，不物化；赋给 vector 才真正的执行
    auto pipeline = views::iota(1, 11)
                  | views::filter([](int x) { return x % 2 == 0; })
                  | views::transform([](int x) { return x * 10; });

    std::vector<int> all(pipeline.begin(), pipeline.end());

    std::cout << "evens doubled:";
    for (int v : all) std::cout << " " << v;
    std::cout << "\n";

    std::cout << "first 3:";
    for (int v : all | views::take(3)) std::cout << " " << v;
    std::cout << "\n";

    std::cout << "sum = " << std::accumulate(all.begin(), all.end(), 0) << "\n";
    return 0;
}
