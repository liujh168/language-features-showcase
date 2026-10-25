// 主题 02：并发模型 —— Rust 版
// Rust 标准库并发：std::thread（1:1 系统线程）+ mpsc channel。
// 编译期检查杜绝数据竞争（Send/Sync trait），join 汇合。
// 更高级的异步并发见 tokio（async/await），属于主题扩展内容。

use std::sync::mpsc;
use std::thread;

fn work(i: i32, tx: mpsc::Sender<(i32, i32)>) {
    // 计算结果通过 channel 发回主线程，而不是共享内存
    tx.send((i, i * 10)).unwrap();
}

fn main() {
    println!("start 4 workers");
    let (tx, rx) = mpsc::channel::<(i32, i32)>();
    let mut handles = vec![];
    for i in 1..=4 {
        let tx = tx.clone();
        // thread::spawn 启动系统线程；move 把 tx 的所有权移进线程
        handles.push(thread::spawn(move || work(i, tx)));
    }
    drop(tx); // 主线程的发送端弃用，rx.iter() 才能正常结束

    let mut results: Vec<(i32, i32)> = rx.iter().collect();
    for h in handles {
        h.join().unwrap(); // 汇合点：等所有线程结束
    }
    results.sort(); // 完成顺序不确定，排序保证输出确定
    for (i, v) in results {
        println!("result from worker {}: {}", i, v);
    }
    println!("all done");
}
