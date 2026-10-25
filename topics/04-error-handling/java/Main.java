// 主题 04：错误处理 —— Java 版
// Java 只有异常一种机制（checked/unchecked 双轨）。
// checked 异常（IOException 等）强制调用方处理——这是 Java 饱受争议的设计。
// 没有 Rust Result / Go error 那样的“错误是值”。

public class Main {
    static int parsePositive(String s) {
        try {
            return Integer.parseInt(s);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("invalid digit");
        }
    }

    static int div(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("division by zero");
        }
        return a / b;
    }

    public static void main(String[] args) {
        for (String s : new String[]{"42", "abc"}) {
            try {
                System.out.println("parse \"" + s + "\" -> " + parsePositive(s));
            } catch (IllegalArgumentException e) {
                System.out.println("parse \"" + s + "\" -> error: " + e.getMessage());
            }
        }
        int[][] cases = {{10, 2}, {10, 0}};
        for (int[] c : cases) {
            try {
                System.out.println(c[0] + " / " + c[1] + " = " + div(c[0], c[1]));
            } catch (ArithmeticException e) {
                System.out.println(c[0] + " / " + c[1] + " -> error: " + e.getMessage());
            }
        }
    }
}
