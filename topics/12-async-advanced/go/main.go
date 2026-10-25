// 主题 12：异步进阶 —— Go 版
// Go 不需要 async 关键字：普通函数前加 go 就是异步任务。
// channel 按完成顺序接收结果——“竞赛”是 Go 并发的自然表达。

package main

import (
	"fmt"
	"time"
)

func work(name string, ms int, done chan<- string) {
	time.Sleep(time.Duration(ms) * time.Millisecond)
	done <- "task " + name + " finished" // 完成即发送，天然按完成顺序
}

func main() {
	fmt.Println("start 3 tasks")
	done := make(chan string, 3)
	go work("fast", 10, done)
	go work("medium", 100, done)
	go work("slow", 300, done)
	for i := 0; i < 3; i++ {
		fmt.Println(<-done) // 谁先完成谁先被打印
	}
	fmt.Println("all settled")
}
