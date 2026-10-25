// 主题 01：泛型 Generics —— Java 版
// Java 泛型 2004 年引入，编译期擦除（与 TypeScript 同源思路）：
// 运行时看不到类型参数，也不能 new T()。基本类型须装箱（int → Integer）。
// 约束用 extends 上限；没有 Rust 那样的 trait bound。

import java.util.List;
import java.util.function.Function;

class Box<T> {
    private final T value;

    Box(T value) { this.value = value; }

    T get() { return value; }

    // <U> 在方法上声明新的类型参数；Function<T, U> 是标准库函数接口
    <U> Box<U> map(Function<T, U> f) {
        return new Box<>(f.apply(value));
    }
}

public class Main {
    // 泛型方法：取列表首元素
    static <T> T first(List<T> items) { return items.get(0); }

    public static void main(String[] args) {
        System.out.println("int box: " + new Box<>(42).get());
        System.out.println("str box: " + new Box<>("hello").get());
        System.out.println("first of [10, 20, 30] = " + first(List.of(10, 20, 30)));
        System.out.println("doubled 21 -> " + new Box<>(21).map(x -> x * 2).get());
    }
}
