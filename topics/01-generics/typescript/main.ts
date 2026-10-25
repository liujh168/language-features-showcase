// 主题 01：泛型 Generics —— TypeScript 版
// TypeScript 的泛型在编译期擦除（erasure），运行时是普通 JS。
// 语法上与 C#/Java 接近：<T> 声明，extends 做约束。

class Box<T> {
  constructor(private value: T) {}

  get(): T {
    return this.value;
  }

  map<U>(f: (v: T) => U): Box<U> {
    return new Box(f(this.value));
  }
}

function first<T>(items: T[]): T {
  return items[0];
}

console.log("int box:", new Box(42).get());
console.log("str box:", new Box("hello").get());
console.log("first of [10, 20, 30] =", first([10, 20, 30]));
console.log("doubled 21 ->", new Box(21).map((x) => x * 2).get());
