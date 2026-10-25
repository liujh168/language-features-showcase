// 主题 11：模块与封装 —— TypeScript 版
// TS/JS 的模块：ES Module（import/export）+ 文件即模块。
// 封装三件套：private 字段（TS 编译期检查）、# 私有字段（JS 原生支持）、
// interface 定义契约。默认导出 vs 命名导出的取舍也是工程话题。

// 契约先行：先定义接口，再实现
interface Greeter {
  greet(): string;
}

// 模块私有（不导出）——同文件内的“实现细节”
function decorate(s: string): string {
  return `${s} from utils`;
}

class Utils implements Greeter {
  greet(): string {
    return decorate("hello");
  }

  area(w: number, h: number): number {
    return w * h;
  }

  makeUser(name: string): User {
    return new User(name);
  }
}

// # 前缀 = JS 原生私有字段（运行时也真正不可见）
class User {
  #name: string;

  constructor(name: string) {
    this.#name = name;
  }

  toString(): string {
    return `User(name=${this.#name})`;
  }
}

const utils = new Utils();
console.log(`utils.greet() = ${utils.greet()}`);
console.log(`area(3, 4) = ${utils.area(3, 4)}`);
console.log(`makeUser("ada") = ${utils.makeUser("ada")}`);
