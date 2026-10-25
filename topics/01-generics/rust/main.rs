// 主题 01：泛型 Generics —— Rust 版
// Rust 泛型零成本抽象：单态化（monomorphization）编译成具体代码，运行无开销。
// 约束通过 trait bound 表达，如 T: Display、T: Copy。

// 注：标准库 prelude 里已有一个智能指针 Box，所以我们的容器命名为 MyBox。
struct MyBox<T> {
    value: T,
}

impl<T> MyBox<T> {
    fn new(value: T) -> Self {
        MyBox { value }
    }

    fn get(&self) -> &T {
        &self.value
    }

    // map 接收一个闭包，把 MyBox<T> 变成 MyBox<U>
    fn map<U>(self, f: impl Fn(T) -> U) -> MyBox<U> {
        MyBox::new(f(self.value))
    }
}

// T: Copy 表示元素类型必须可按位复制（i32 满足）。
fn first<T: Copy>(items: &[T]) -> T {
    items[0]
}

fn main() {
    println!("int box: {}", MyBox::new(42).get());
    println!("str box: {}", MyBox::new("hello").get());
    println!("first of [10, 20, 30] = {}", first(&[10, 20, 30]));
    println!("doubled 21 -> {}", MyBox::new(21).map(|x| x * 2).get());
}
