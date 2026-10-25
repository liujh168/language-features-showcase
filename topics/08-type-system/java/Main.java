// 主题 08：类型系统 —— Java 版
// Java 是名义类型（nominal typing）：必须显式 implements 接口才算“会叫”。
// 与 Python 鸭子类型正相反——编译器按“声明的名字”而非“实际有的方法”检查。
// 代价：新增能力要改声明；收益：接口契约显式、IDE 支持强。

interface Speaker {
    String speak();
}

class Dog implements Speaker {
    @Override
    public String speak() { return "woof"; }
}

class Cat implements Speaker {
    @Override
    public String speak() { return "meow"; }
}

public class Main {
    public static void main(String[] args) {
        Speaker[] animals = {new Dog(), new Cat()};
        String[] names = {"dog", "cat"};
        for (int i = 0; i < animals.length; i++) {
            System.out.println(names[i] + " says: " + animals[i].speak());
        }
    }
}
