// 主题 10：资源管理 —— Rust 版
// Rust 无 GC：内存由所有权自动释放（Drop），确定性析构。
// 缓冲区池在 Rust 里通常做成 RAII 包装（Guard 模式）：获取即借出，
// 离开作用域自动归还。本题为与其他语言对齐，显式调用 release。

struct BufferPool;

impl BufferPool {
    fn acquire(&self, name: &str) -> String {
        println!("allocate buffer {}", name);
        name.to_string()
    }

    fn release(&self, buf: &str) {
        println!("return {} to pool", buf);
    }
}

fn main() {
    let pool = BufferPool;
    let a = pool.acquire("A");
    let b = pool.acquire("B");
    println!("use {} + {}", a, b);
    pool.release(&a);
    pool.release(&b);
    println!("all buffers back in pool");
}
