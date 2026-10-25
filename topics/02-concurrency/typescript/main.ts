// 主题 02：并发模型 —— TypeScript 版
// JS 单线程事件循环，并发 = 异步任务交错执行（不是并行）。
// 原语：Promise / async-await；编排靠 Promise.all 汇合。

async function work(i: number): Promise<[number, number]> {
  // await 挂起当前协程，让出事件循环——这就是 JS 的“并发”
  await new Promise((r) => setTimeout(r, 10)); // 模拟异步 IO
  return [i, i * 10];
}

async function main() {
  console.log("start 4 workers");
  // 4 个任务同时挂到事件循环上，Promise.all 等待全部完成（join）
  const results = await Promise.all([1, 2, 3, 4].map(work));
  results.sort((a, b) => a[0] - b[0]); // 完成顺序不确定，排序保证输出确定
  for (const [i, v] of results) {
    console.log(`result from worker ${i}: ${v}`);
  }
  console.log("all done");
}

main();
