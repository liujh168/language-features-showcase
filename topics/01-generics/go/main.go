// 主题 01：泛型 Generics —— Go 版
// Go 1.18 才引入泛型。类型参数写在方括号里：[T any]。
// any 是 interface{} 的别名；可用 comparable 等约束限制类型集合。

package main

import "fmt"

// Box 泛型容器，T 可以是任何类型。
type Box[T any] struct {
	value T
}

func (b Box[T]) Get() T {
	return b.value
}

// Map 把 Box[T] 变成 Box[U]：泛型函数 + 高阶函数的组合。
func Map[T, U any](b Box[T], f func(T) U) Box[U] {
	return Box[U]{f(b.value)}
}

// First 取切片第一个元素。
func First[T any](items []T) T {
	return items[0]
}

func main() {
	fmt.Println("int box:", Box[int]{value: 42}.Get())
	fmt.Println("str box:", Box[string]{value: "hello"}.Get())
	fmt.Println("first of [10, 20, 30] =", First([]int{10, 20, 30}))
	fmt.Println("doubled 21 ->", Map(Box[int]{value: 21}, func(x int) int { return x * 2 }).Get())
}
