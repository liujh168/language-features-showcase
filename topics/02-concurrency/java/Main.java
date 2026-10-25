// 主题 02：并发模型 —— Java 版
// Java 21 虚拟线程（JEP 444）：轻量协程，由 JVM 调度——
// “一个线程一个任务”的代码写法，goroutine 级别的开销。
// 汇合用 Future.get()；旧时代的线程池是 Executors.newFixedThreadPool。

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {
    static int work(int i) { return i * 10; }

    public static void main(String[] args) throws Exception {
        System.out.println("start 4 workers");
        // 虚拟线程：每个任务一个线程，开销与 goroutine 同量级
        ExecutorService pool = Executors.newVirtualThreadPerTaskExecutor();
        List<Future<int[]>> futures = new ArrayList<>();
        for (int i = 1; i <= 4; i++) {
            final int n = i;
            futures.add(pool.submit(() -> new int[]{n, work(n)}));
        }
        List<int[]> results = new ArrayList<>();
        for (Future<int[]> f : futures) {
            results.add(f.get()); // 汇合点：阻塞直到任务完成
        }
        pool.shutdown();
        results.sort(Comparator.comparingInt(r -> r[0]));
        for (int[] r : results) {
            System.out.println("result from worker " + r[0] + ": " + r[1]);
        }
        System.out.println("all done");
    }
}
