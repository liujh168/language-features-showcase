// 主题 12：异步进阶 —— Rust 版（tokio 异步运行时）
// async/await 只是语法；真正驱动协程的是运行时。Rust 把选择权交给生态，
// tokio 是事实标准。#[tokio::main] 即“启动一个多线程调度器”。

use tokio::time::{sleep, Duration};

async fn work(name: &str, ms: u64) {
    sleep(Duration::from_millis(ms)).await; // .await 挂起点，让出线程
    println!("task {} finished", name);
}

#[tokio::main(flavor = "multi_thread", worker_threads = 2)]
async fn main() {
    println!("start 3 tasks");
    // join! 同时推进三个协程，完成顺序 = 定时器先后
    tokio::join!(
        work("fast", 10),
        work("medium", 100),
        work("slow", 300),
    );
    println!("all settled");
}
