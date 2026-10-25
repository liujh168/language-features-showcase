// 主题 07：宏与元编程 —— Rust 版
// macro_rules! 声明宏：在语法树上做模式替换（比 C 预处理强大得多——
// 它操作的是 token 树而非纯文本）。过程宏（derive 等）是更进一步的元编程。

macro_rules! square {
    ($x:expr) => { $x * $x }; // $x:expr 匹配任意表达式
}

macro_rules! cube {
    ($x:expr) => { $x * $x * $x };
}

fn main() {
    println!("square(7) = {}", square!(7));
    println!("cube(3) = {}", cube!(3));
}
