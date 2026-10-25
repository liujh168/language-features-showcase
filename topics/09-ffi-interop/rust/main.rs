// 主题 09：FFI 与互操作 —— Rust 版
// Rust 的 FFI 是一等公民能力：extern "C" 声明 + unsafe 块调用。
// 开销为零（直接函数调用），代价是越过安全边界——一切交给程序员担保。
// C 字符串需用 CString 保证 NUL 结尾。

use std::ffi::CString;
use std::os::raw::c_char;

// 声明 C 标准库的 strlen（链接时从 UCRT 解析）
extern "C" {
    fn strlen(s: *const c_char) -> usize;
}

fn str_len(s: &str) -> usize {
    let c = CString::new(s).unwrap(); // Rust &str → C 字符串（补 NUL）
    unsafe { strlen(c.as_ptr()) }     // FFI 调用必须包在 unsafe 里
}

fn main() {
    for s in ["hello", "modern languages"] {
        println!("strlen(\"{}\") = {}", s, str_len(s));
    }
}
