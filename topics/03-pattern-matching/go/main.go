// 主题 03：模式匹配 —— Go 版
// Go 没有模式匹配。惯用替代：无 tag 的 switch（等价 if-else 链）。
// 注意 Go 的 switch 默认不贯穿（无需 break），这与 C 系传统相反。

package main

import "fmt"

func classify(n int) string {
	switch {
	case n == 0:
		return "zero"
	case n == 1:
		return "one"
	case n < 0:
		return "negative"
	case n%2 == 0:
		return "even"
	default:
		return "odd"
	}
}

func main() {
	for _, n := range []int{0, 1, -3, 42, 7} {
		fmt.Printf("classify(%d) = %s\n", n, classify(n))
	}
}
