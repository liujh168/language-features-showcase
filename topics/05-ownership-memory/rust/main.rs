// 主题 05：所有权与内存 —— Rust 版
// 所有权三规则：每个值有且只有一个所有者；所有者离开作用域值被释放；
// 赋值/传参默认移动（move），Copy 类型除外。Drop trait 定制清理动作。
// 这里用 RAII 式资源类展示“释放时机是编译期就确定的”。

struct Resource {
    id: i32,
}

impl Resource {
    fn new(id: i32) -> Self {
        println!("acquire resource #{}", id);
        Resource { id }
    }
}

impl Drop for Resource {
    fn drop(&mut self) {
        println!("release resource #{}", self.id);
    }
}

fn use_it() {
    let _r = Resource::new(1); // 离开本作用域时自动 drop，无需手写释放
    println!("use resource #1");
} // <- _r 在这里被释放（先打印 release，函数才返回）

fn main() {
    use_it();
    println!("done");
}
