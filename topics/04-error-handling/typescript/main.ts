// 主题 04：错误处理 —— TypeScript 版
// TS/JS 用 throw/try-catch，但 Number("abc") 返回 NaN 而不是抛错——
// 所以必须自己写校验函数主动抛异常，才能模拟“解析失败”语义。

function parsePositive(s: string): number {
  if (!/^\d+$/.test(s)) throw new Error("invalid digit");
  return Number(s);
}

function div(a: number, b: number): number {
  if (b === 0) throw new Error("division by zero");
  return a / b;
}

function show(label: string, f: () => number): void {
  try {
    console.log(label + f());
  } catch (e) {
    console.log(label + "error: " + (e as Error).message);
  }
}

show('parse "42" -> ', () => parsePositive("42"));
show('parse "abc" -> ', () => parsePositive("abc"));
show("10 / 2 = ", () => div(10, 2));
show("10 / 0 -> ", () => div(10, 0));
