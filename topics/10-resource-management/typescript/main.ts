// 主题 10：资源管理 —— TypeScript 版
// JS 有 tracing GC（分代回收），同 Java：内存时机不可控。
// 且 JS 的“资源”更多是浏览器/宿主资源（句柄、订阅、定时器）——
// 归还纪律用显式 dispose()/unsubscribe() 或较新的 Explicit Resource Management（using）。
// 本题用 BufferPool 演示相同的 acquire/release 约定。

class BufferPool {
  acquire(name: string): string {
    console.log(`allocate buffer ${name}`);
    return name;
  }

  release(buf: string): void {
    console.log(`return ${buf} to pool`);
  }
}

const pool = new BufferPool();
const a = pool.acquire("A");
const b = pool.acquire("B");
console.log(`use ${a} + ${b}`);
pool.release(a);
pool.release(b);
console.log("all buffers back in pool");
