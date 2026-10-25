// 主题 03：模式匹配 —— Rust 版
// match 是表达式（可返回值），支持字面量、绑定、守卫（guard）、穷尽性检查。

fn classify(n: i32) -> &'static str {
    match n {
        0 => "zero",
        1 => "one",
        n if n < 0 => "negative",      // 守卫：任意布尔条件
        n if n % 2 == 0 => "even",
        _ => "odd",                     // 通配；漏掉它会编译报错（非穷尽）
    }
}

fn main() {
    for n in [0, 1, -3, 42, 7] {
        println!("classify({}) = {}", n, classify(n));
    }
}
