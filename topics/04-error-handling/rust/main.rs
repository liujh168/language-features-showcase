// 主题 04：错误处理 —— Rust 版
// Result<T, E> 是类型系统的一部分：错误是返回值，不是控制流异常。
// 好处：可能的失败写在函数签名上，编译器逼你处理（或显式 unwrap/忽略）。

fn parse_positive(s: &str) -> Result<i32, String> {
    s.parse::<i32>().map_err(|_| "invalid digit".to_string())
}

fn div(a: i32, b: i32) -> Result<i32, String> {
    if b == 0 {
        return Err("division by zero".to_string());
    }
    Ok(a / b)
}

fn main() {
    for s in ["42", "abc"] {
        match parse_positive(s) {
            Ok(v) => println!("parse \"{}\" -> {}", s, v),
            Err(e) => println!("parse \"{}\" -> error: {}", s, e),
        }
    }
    for (a, b) in [(10, 2), (10, 0)] {
        match div(a, b) {
            Ok(v) => println!("{} / {} = {}", a, b, v),
            Err(e) => println!("{} / {} -> error: {}", a, b, e),
        }
    }
}
