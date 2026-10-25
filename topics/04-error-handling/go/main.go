// 主题 04：错误处理 —— Go 版
// Go 的错误处理哲学：错误是普通的返回值 (T, error)，不是异常。
// 没有 try-catch，每个可能失败的调用都显式检查 err——啰嗦但一目了然。

package main

import (
	"errors"
	"fmt"
	"strconv"
)

func parsePositive(s string) (int, error) {
	n, err := strconv.Atoi(s)
	if err != nil {
		return 0, errors.New("invalid digit") // 包装成业务语义的错误
	}
	return n, nil
}

func div(a, b int) (int, error) {
	if b == 0 {
		return 0, errors.New("division by zero")
	}
	return a / b, nil
}

func main() {
	if v, err := parsePositive("42"); err != nil {
		fmt.Println(`parse "42" -> error:`, err)
	} else {
		fmt.Println(`parse "42" ->`, v)
	}
	if v, err := parsePositive("abc"); err != nil {
		fmt.Println(`parse "abc" -> error:`, err)
	} else {
		fmt.Println(`parse "abc" ->`, v)
	}
	if v, err := div(10, 2); err != nil {
		fmt.Println("10 / 2 -> error:", err)
	} else {
		fmt.Println("10 / 2 =", v)
	}
	if v, err := div(10, 0); err != nil {
		fmt.Println("10 / 0 -> error:", err)
	} else {
		fmt.Println("10 / 0 =", v)
	}
}
