// 主题 12：异步进阶 —— Java 版
// CompletableFuture：Java 8 起的异步编排框架，thenCompose/allOf 组合任务链。
// Java 21 的虚拟线程（见主题 02）出现后，CF + 虚拟线程成为新主流写法。

import java.util.concurrent.CompletableFuture;

public class Main {
    // 延迟 ms 后打印完成——CompletableFuture 异步任务
    static CompletableFuture<Void> work(String name, int ms) {
        return CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(ms);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
            System.out.println("task " + name + " finished");
        });
    }

    public static void main(String[] args) {
        System.out.println("start 3 tasks");
        CompletableFuture<Void> all = CompletableFuture.allOf(
                work("fast", 10),
                work("medium", 100),
                work("slow", 300));
        all.join(); // 等全部完成（完成顺序由 sleep 长短决定）
        System.out.println("all settled");
    }
}
