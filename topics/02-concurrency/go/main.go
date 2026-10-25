// 主题 02：并发模型 —— Go 版
// Go 的招牌：goroutine（轻量线程，几 KB 栈）+ channel（通信共享内存）。
// 调度由运行时接管，开发者只管 go 关键字启动、WaitGroup 汇合。

package main

import (
	"fmt"
	"sort"
	"sync"
)

func work(i int, wg *sync.WaitGroup, ch chan<- [2]int) {
	defer wg.Done() // 通知 WaitGroup：我干完了
	ch <- [2]int{i, i * 10}
}

func main() {
	fmt.Println("start 4 workers")
	ch := make(chan [2]int, 4)
	var wg sync.WaitGroup
	for i := 1; i <= 4; i++ {
		wg.Add(1)
		go work(i, &wg, ch) // go 关键字：启动一个 goroutine
	}
	wg.Wait() // 汇合点：等 4 个 goroutine 全部结束
	close(ch)

	var results [][2]int
	for r := range ch {
		results = append(results, r)
	}
	sort.Slice(results, func(a, b int) bool { return results[a][0] < results[b][0] })
	for _, r := range results {
		fmt.Printf("result from worker %d: %d\n", r[0], r[1])
	}
	fmt.Println("all done")
}
