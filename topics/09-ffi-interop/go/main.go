// 主题 09：FFI 与互操作 —— Go 版
// Go 调 Windows DLL 有两条路：
//   1. cgo（需 gcc，跨平台，但跨了 C 边界就不能用 goroutine 调度优化）
//   2. syscall.NewLazyDLL —— 纯 Go 直接调 DLL，本 demo 用这条路（仅 Windows）
// 生产环境调 C 库还是 cgo / 纯 Go 重写二选一。

package main

import (
	"fmt"
	"syscall"
	"unsafe"
)

// 懒加载 ucrtbase.dll（UCRT，C 标准库所在）中的 strlen
var strlen = syscall.NewLazyDLL("ucrtbase.dll").NewProc("strlen")

func strLen(s string) int {
	p, _ := syscall.BytePtrFromString(s) // Go 字符串 → C 字符指针
	n, _, _ := strlen.Call(uintptr(unsafe.Pointer(p)))
	return int(n)
}

func main() {
	for _, s := range []string{"hello", "modern languages"} {
		fmt.Printf("strlen(\"%s\") = %d\n", s, strLen(s))
	}
}
