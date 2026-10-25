// 主题 05：所有权与内存 —— Go 版
// Go 是 GC 语言（内存自动回收），但确定性清理有专门原语：defer。
// defer 在函数退出时按 LIFO 顺序执行——等价于“函数作用域的析构”。

package main

import "fmt"

func acquire(id int) func() {
	fmt.Printf("acquire resource #%d\n", id)
	return func() { fmt.Printf("release resource #%d\n", id) }
}

func useIt() {
	release := acquire(1)
	defer release() // 注册在函数退出时执行，无论是否 panic
	fmt.Println("use resource #1")
} // <- release() 在这里执行

func main() {
	useIt()
	fmt.Println("done")
}
