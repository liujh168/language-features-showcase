// 主题 10：资源管理 —— Go 版
// Go 有 GC，内存自动回收；但“池化资源”（连接、句柄、缓冲区）依然要显式归还。
// 标准库以身作则：sync.Pool、http.Response.Body.Close()、rows.Close()。
// 本题用自定义 BufferPool 演示同一条纪律：acquire 配 release。

package main

import "fmt"

type BufferPool struct{}

func (BufferPool) Acquire(name string) string {
	fmt.Println("allocate buffer", name)
	return name
}

func (BufferPool) Release(buf string) {
	fmt.Println("return", buf, "to pool")
}

func main() {
	var pool BufferPool
	a := pool.Acquire("A")
	b := pool.Acquire("B")
	fmt.Println("use", a, "+", b)
	pool.Release(a)
	pool.Release(b)
	fmt.Println("all buffers back in pool")
}
