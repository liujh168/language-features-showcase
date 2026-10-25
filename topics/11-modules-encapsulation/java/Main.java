// 主题 11：模块与封装 —— Java 版
// Java 四级可见性：public / protected / 默认（包私有）/ private。
// 老 Java 靠 package 划分边界；Java 9 引入 JPMS 模块系统（module-info.java），
// 本 demo 为单文件从简，但可见性语法与模块思想一致。

// record：Java 16+ 的不可变数据类，自动生成构造器/访问器/toString
record User(String name) {
    @Override
    public String toString() {
        return "User(name=" + name + ")"; // 默认格式是 User[name=ada]，对齐输出而覆盖
    }
}

class Utils {
    // 私有：类内部实现细节
    private static String decorate(String s) {
        return s + " from utils";
    }

    // 公开 API（对包外可见）
    public static String greet() {
        return decorate("hello");
    }

    public static int area(int w, int h) {
        return w * h;
    }

    public static User makeUser(String name) {
        return new User(name);
    }
}

public class Main {
    public static void main(String[] args) {
        System.out.println("utils.greet() = " + Utils.greet());
        System.out.println("area(3, 4) = " + Utils.area(3, 4));
        System.out.println("makeUser(\"ada\") = " + Utils.makeUser("ada"));
    }
}
