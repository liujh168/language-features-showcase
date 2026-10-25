// 主题 07：宏与元编程 —— Java 版
// Java 没有宏。它的元编程分两层：
//   运行期：反射 + 动态代理（本 demo）——只能代理接口；
//   编译期：注解处理（APT，如 Lombok 生成 getter）——需要构建工具配合。
// 函数不是一等公民，必须先包成函数接口（IntFn）才能被代理。

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

interface IntFn { int apply(int x); }

public class Main {
    // 类似 Python 装饰器：返回一个“包装后的函数”
    static IntFn logged(IntFn fn) {
        InvocationHandler handler = (proxy, method, args) -> method.invoke(fn, args);
        return (IntFn) Proxy.newProxyInstance(
                Main.class.getClassLoader(),
                new Class<?>[]{IntFn.class},
                handler);
    }

    public static void main(String[] args) {
        IntFn square = logged(x -> x * x);       // 等价于 square = logged(square)
        IntFn cube = logged(x -> x * x * x);
        System.out.println("square(7) = " + square.apply(7));
        System.out.println("cube(3) = " + cube.apply(3));
    }
}
