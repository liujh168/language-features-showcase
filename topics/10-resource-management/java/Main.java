// 主题 10：资源管理 —— Java 版
// JVM 有 tracing GC：内存回收完全由运行时决定，程序无法精确控制时机。
// 但池化资源的归还与其他语言完全一致——靠显式 close()（try-with-resources）。
// GC 管内存，资源纪律靠代码：这是所有 GC 语言共同的工程教训。

class BufferPool {
    String acquire(char name) {
        System.out.println("allocate buffer " + name);
        return String.valueOf(name);
    }

    void release(String buf) {
        System.out.println("return " + buf + " to pool");
    }
}

public class Main {
    public static void main(String[] args) {
        BufferPool pool = new BufferPool();
        String a = pool.acquire('A');
        String b = pool.acquire('B');
        System.out.println("use " + a + " + " + b);
        pool.release(a);
        pool.release(b);
        System.out.println("all buffers back in pool");
    }
}
