// 主题 12：异步进阶 —— TypeScript 版
// 单线程事件循环跑 async 任务：sleep 期间让出，完成顺序 = 延迟顺序。
// 对比主题 02：这里看的是“任务完成竞赛”，async 编排的真价值在 IO 并发。

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function work(name: string, ms: number): Promise<void> {
  await sleep(ms); // 挂起点：事件循环转去跑别的任务
  console.log(`task ${name} finished`);
}

async function main() {
  console.log("start 3 tasks");
  // 三个任务同时挂上事件循环；完成顺序由 sleep 长短决定
  await Promise.all([work("fast", 10), work("medium", 100), work("slow", 300)]);
  console.log("all settled");
}

main();
