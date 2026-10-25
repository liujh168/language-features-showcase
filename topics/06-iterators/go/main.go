// 主题 06：迭代器与流 —— Go 版
// 经典 Go 没有惰性迭代器管道（filter/map 要从头写循环），
// 这是刻意的语言设计：可读性优先于链式表达。
// （Go 1.23 起标准库新增 iter 包与 range-over-func，可写惰性管道，
//  但社区惯用写法仍是下面的显式循环。）

package main

import (
	"fmt"
	"strconv"
	"strings"
)

func evensDoubled() []int {
	var out []int
	for x := 1; x <= 10; x++ {
		if x%2 == 0 {
			out = append(out, x*10)
		}
	}
	return out
}

func main() {
	all := evensDoubled()

	parts := make([]string, len(all))
	for i, v := range all {
		parts[i] = strconv.Itoa(v)
	}
	fmt.Println("evens doubled:", strings.Join(parts, " "))
	fmt.Println("first 3:", strings.Join(parts[:3], " "))

	sum := 0
	for _, v := range all {
		sum += v
	}
	fmt.Println("sum =", sum)
}
