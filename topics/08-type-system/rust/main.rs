// 主题 08：类型系统 —— Rust 版
// trait = 接口，但实现与类型定义解耦（可给外部类型实现本地 trait）。
// dyn Animal 是动态分发（vtable）；泛型 + impl Animal 是静态分发（单态化）。

trait Animal {
    fn speak(&self) -> &'static str;
}

struct Dog;
struct Cat;

impl Animal for Dog {
    fn speak(&self) -> &'static str {
        "woof"
    }
}

impl Animal for Cat {
    fn speak(&self) -> &'static str {
        "meow"
    }
}

fn main() {
    let dog = Dog;
    let cat = Cat;
    // &dyn Animal = 动态分发：同一个接口，运行期决定调谁
    let animals: [(&str, &dyn Animal); 2] = [("dog", &dog), ("cat", &cat)];
    for (name, a) in animals {
        println!("{} says: {}", name, a.speak());
    }
}
