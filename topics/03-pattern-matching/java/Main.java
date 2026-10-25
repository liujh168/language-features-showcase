// 主题 03：模式匹配 —— Java 版
// Java 21 正式落地 switch 模式匹配（JEP 441）：
// 支持类型模式 + 守卫（when）+ null 处理。比 Rust 晚，比 Python 强在能解构 record。
// 注意：default 必须写，编译器对守卫不做穷尽性保证。

public class Main {
    static String classify(Integer n) {
        return switch (n) {
            case 0 -> "zero";
            case 1 -> "one";
            case Integer i when i < 0  -> "negative";   // 类型模式 + 守卫
            case Integer i when i % 2 == 0 -> "even";
            default -> "odd";
        };
    }

    public static void main(String[] args) {
        for (int n : new int[]{0, 1, -3, 42, 7}) {
            System.out.println("classify(" + n + ") = " + classify(n));
        }
    }
}
