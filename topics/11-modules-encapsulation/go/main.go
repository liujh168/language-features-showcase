// 主题 11：模块与封装 —— Go 版
// Go 的封装最极简：大小写即可见性。首字母大写 = 公开（包外可见），
// 小写 = 包内私有。没有 public/private 关键字，没有头文件。

package main

import "fmt"

// ---- utils “包”（这里同文件模拟）----
// 小写开头 = 私有，细节实现
func decorate(s string) string { return s + " from utils" }

// 大写开头 = 公开 API
func Greet() string { return decorate("hello") }

func Area(w, h int) int { return w * h }

type User struct {
	name string // 小写字段 = 包外不可见，必须通过构造/方法访问
}

func (u User) String() string { return "User(name=" + u.name + ")" }

func MakeUser(name string) User { return User{name: name} }

// ---- main ----
func main() {
	fmt.Println("utils.greet() =", Greet())
	fmt.Println("area(3, 4) =", Area(3, 4))
	fmt.Println("makeUser(\"ada\") =", MakeUser("ada"))
}
