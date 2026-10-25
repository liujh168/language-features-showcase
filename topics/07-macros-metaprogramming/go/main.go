// 主题 07：宏与元编程 —— Go 版
// Go 是“反元编程”设计：没有宏、没有模板、没有泛型元编程
// （1.18 的范型也不支持任何计算）。
// 官方认可的代码生成入口是 //go:generate 指令（调外部工具生成代码）。

package main

import "fmt"

func square(x int) int { return x * x }

func cube(x int) int { return x * x * x }

func main() {
	fmt.Println("square(7) =", square(7))
	fmt.Println("cube(3) =", cube(3))
}
