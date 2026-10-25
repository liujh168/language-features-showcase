// 主题 06：迭代器与流 —— Java 版
// Java 8 引入 Stream API：filter/map 惰性流水线，终端操作才触发求值。
// 两个要点：① Stream 只能消费一次；② 惰性 = 中间操作不真正计算。

import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Main {
    // 每次调用返回一个新的流（流不可复用，这是新手最常踩的坑）
    static IntStream evensDoubled() {
        return IntStream.rangeClosed(1, 10)
                .filter(x -> x % 2 == 0)
                .map(x -> x * 10);
    }

    static String join(IntStream s) {
        return s.mapToObj(String::valueOf).collect(Collectors.joining(" "));
    }

    public static void main(String[] args) {
        System.out.println("evens doubled: " + join(evensDoubled()));
        System.out.println("first 3: " + join(evensDoubled().limit(3)));
        System.out.println("sum = " + evensDoubled().sum());
    }
}
