// 主题 06：迭代器与流 —— Rust 版
// 迭代器是惰性的：filter/map 只是搭管道，collect/sum/take 才真正驱动。
// 零开销抽象：编译后等价于手写循环。

fn main() {
    let all: Vec<i32> = (1..=10)
        .filter(|x| x % 2 == 0)  // 惰性：不产生中间容器
        .map(|x| x * 10)
        .collect();              // 消费迭代器，物化结果

    print!("evens doubled:");
    for v in &all {
        print!(" {}", v);
    }
    println!();

    let first3: Vec<i32> = all.iter().take(3).copied().collect();
    print!("first 3:");
    for v in &first3 {
        print!(" {}", v);
    }
    println!();

    println!("sum = {}", all.iter().sum::<i32>());
}
