// 主题 02：并发模型 —— C++ 版
// C++11 起标准库提供 std::thread / std::async / std::future。
// 这里用 std::async(std::launch::async) 起线程池式任务，
// future.get() 即汇合点。注意：裸 std::thread 忘了 join 会 terminate。

#include <algorithm>
#include <chrono>
#include <iostream>
#include <future>
#include <string>
#include <thread>
#include <utility>
#include <vector>

int work(int i) {
    // 模拟耗时操作；线程在此挂起时其他线程并行推进
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
    return i * 10;
}

int main() {
    std::cout << "start 4 workers\n";
    std::vector<std::future<std::pair<int, int>>> futures;
    for (int i = 1; i <= 4; i++) {
        // std::async 启动异步任务，返回 future（任务的“提货单”）
        futures.push_back(std::async(std::launch::async,
                                     [i] { return std::make_pair(i, work(i)); }));
    }
    std::vector<std::pair<int, int>> results;
    for (auto& f : futures) {
        results.push_back(f.get()); // 汇合：阻塞直到任务完成并取回结果
    }
    std::sort(results.begin(), results.end());
    for (const auto& [i, v] : results) {
        std::cout << "result from worker " << i << ": " << v << "\n";
    }
    std::cout << "all done\n";
    return 0;
}
