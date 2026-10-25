// 主题 12：异步进阶 —— C++ 版
// C++20 有协程（co_await），但标准库没有现成运行时——写个 awaitable
// 调度器要上百行。工程上仍普遍用 std::async / 线程池 + future。
// 本题沿用 std::async：任务在各自线程里 sleep，完成顺序即输出顺序。

#include <chrono>
#include <iostream>
#include <string>
#include <thread>
#include <utility>
#include <vector>
#include <future>

void work(const std::string& name, int ms) {
    std::this_thread::sleep_for(std::chrono::milliseconds(ms));
    std::cout << "task " << name << " finished" << std::endl; // endl 刷新，避免线程间串行缓冲
}

int main() {
    std::cout << "start 3 tasks\n";
    std::vector<std::pair<std::string, int>> specs = {
        {"fast", 10}, {"medium", 100}, {"slow", 300}
    };
    std::vector<std::future<void>> futures;
    for (const auto& [name, ms] : specs) {
        futures.push_back(std::async(std::launch::async, [name, ms] { work(name, ms); }));
    }
    for (auto& f : futures) {
        f.get(); // 等全部结束（完成顺序由 sleep 长短决定）
    }
    std::cout << "all settled\n";
    return 0;
}
