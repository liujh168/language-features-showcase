"""主题 08：类型系统 —— Python 版
鸭子类型：不继承、不声明接口，只要对象“长得像”（有 speak 方法）就能用。
类型检查器时代可以补 Protocol（结构化类型）做静态约束，但运行时不强制。
"""


class Dog:
    def speak(self) -> str:
        return "woof"


class Cat:
    def speak(self) -> str:
        return "meow"


# Dog/Cat 没有共同基类——它们唯一的“接口”就是都有 speak()
if __name__ == "__main__":
    for name, a in [("dog", Dog()), ("cat", Cat())]:
        print(f"{name} says: {a.speak()}")
