// 主题 11：模块与封装 —— Rust 版
// Rust 模块系统：mod 树 + pub 标记。默认私有，显式 pub 才公开——
// “默认隐藏”与 Go（默认私有）、Java（默认包私有）的折中不同。

mod utils {
    // 私有辅助函数：模块内随便用，模块外不存在
    fn decorate(s: &str) -> String {
        format!("{} from utils", s)
    }

    // pub = 对外公开
    pub fn greet() -> String {
        decorate("hello")
    }

    pub fn area(w: i32, h: i32) -> i32 {
        w * h
    }

    // 字段私有 + 构造函数公开 = 封装
    pub struct User {
        name: String, // 未标 pub：模块外不可访问
    }

    impl User {
        pub fn name(&self) -> &str {
            &self.name
        }
    }

    pub fn make_user(name: &str) -> User {
        User {
            name: name.to_string(),
        }
    }
}

use utils::User;

// 为外部类型实现外部 trait（Display）需要孤儿规则豁免——这里 User 是本地类型，合法
impl std::fmt::Display for User {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "User(name={})", self.name())
    }
}

fn main() {
    println!("utils.greet() = {}", utils::greet());
    println!("area(3, 4) = {}", utils::area(3, 4));
    println!("makeUser(\"ada\") = {}", utils::make_user("ada"));
}
