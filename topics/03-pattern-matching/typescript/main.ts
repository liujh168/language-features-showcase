// 主题 03：模式匹配 —— TypeScript 版
// TS 没有真正的模式匹配（TC39 的 pattern-matching 提案仍在路上）。
// 现实写法：switch 处理离散值 + if 守卫补条件分支。

function classify(n: number): string {
  switch (n) {
    case 0:
      return "zero";
    case 1:
      return "one";
  }
  // switch 覆盖不了条件分支，守卫要退回 if
  if (n < 0) return "negative";
  if (n % 2 === 0) return "even";
  return "odd";
}

for (const n of [0, 1, -3, 42, 7]) {
  console.log(`classify(${n}) = ${classify(n)}`);
}
