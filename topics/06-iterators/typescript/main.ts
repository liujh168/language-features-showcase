// 主题 06：迭代器与流 —— TypeScript 版
// 数组的 map/filter 是【立即求值】的：每次都生成新数组。
// 惰性要靠 generator 函数（function*）。日常代码里前者占绝对主流——
// 数据量不大时简单直白比惰性更重要。

function* evensDoubled(): Generator<number> {
  for (let x = 1; x <= 10; x++) {
    if (x % 2 === 0) yield x * 10;
  }
}

const nums = Array.from({ length: 10 }, (_, i) => i + 1);
const evens = nums.filter((x) => x % 2 === 0).map((x) => x * 10); // 立即物化

console.log("evens doubled:", evens.join(" "));
console.log("first 3:", evens.slice(0, 3).join(" "));
console.log("sum =", evens.reduce((a, b) => a + b, 0));
