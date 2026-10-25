// 主题 05：所有权与内存 —— Java 版
// Java 是 GC 语言：内存由垃圾回收器托管，没有析构时机的确定性保证。
// 但“确定性清理”另有标准答案：try-with-resources（AutoCloseable 接口），
// 等价于 Python 的 with、C++ 的 RAII——释放时机回到代码控制。

class Resource implements AutoCloseable {
    private final int rid;

    Resource(int rid) {
        this.rid = rid;
        System.out.println("acquire resource #" + rid);
    }

    int id() { return rid; }

    @Override
    public void close() {
        System.out.println("release resource #" + rid);
    }
}

public class Main {
    public static void main(String[] args) {
        // 进入 try 构造（acquire），离开块时自动 close（release），即便抛异常也保证执行
        try (Resource r = new Resource(1)) {
            System.out.println("use resource #" + r.id());
        }
        System.out.println("done");
    }
}
