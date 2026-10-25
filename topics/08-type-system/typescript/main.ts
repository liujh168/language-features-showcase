// 主题 08：类型系统 —— TypeScript 版
// TS 是结构化类型（structural typing）：接口不要求显式 implements，
// 只要结构匹配即可——这是它和 Java/C# 名义类型系统的根本区别。

interface Animal {
  speak(): string;
}

class Dog implements Animal {
  speak() {
    return "woof";
  }
}

class Cat implements Animal {
  speak() {
    return "meow";
  }
}

const animals: [string, Animal][] = [
  ["dog", new Dog()],
  ["cat", new Cat()],
];
for (const [name, a] of animals) {
  console.log(`${name} says: ${a.speak()}`);
}
