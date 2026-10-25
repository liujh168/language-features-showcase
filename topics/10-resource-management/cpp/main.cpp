// 主题 10：资源管理 —— C++ 版
// C++ 没有 GC：内存靠 RAII（构造获取、析构释放），缓冲区池同理。
// 本题的“归还”全部由代码显式控制，时机 100% 确定。

#include <iostream>
#include <string>

class BufferPool {
public:
    // 从池中取一个缓冲区（打印 allocate）
    std::string acquire(char name) {
        std::cout << "allocate buffer " << name << "\n";
        return std::string(1, name);
    }

    // 用完必须归还——谁申请谁归还，和 delete/delete[] 同一条纪律
    void release(const std::string& buf) {
        std::cout << "return " << buf << " to pool\n";
    }
};

int main() {
    BufferPool pool;
    std::string a = pool.acquire('A');
    std::string b = pool.acquire('B');
    std::cout << "use " << a << " + " << b << "\n";
    pool.release(a);
    pool.release(b);
    std::cout << "all buffers back in pool\n";
    return 0;
}
