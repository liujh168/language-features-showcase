// 主题 05：所有权与内存 —— TypeScript 版
// JS/TS 是 GC 语言，且对象析构（finalize）在语言层面不可依赖。
// 确定性清理的替代：try-finally 手动 close；内存本身交给垃圾回收器。

class Resource {
  constructor(private id: number) {}

  acquire() {
    console.log(`acquire resource #${this.id}`);
  }

  release() {
    console.log(`release resource #${this.id}`);
  }
}

const r = new Resource(1);
r.acquire();
try {
  console.log("use resource #1");
} finally {
  r.release(); // 无论是否异常都会执行——JS 版的 RAII 模拟
}
console.log("done");
