// 主题 08：类型系统 —— Go 版
// Go 接口是隐式实现：不用写 implements，方法集匹配即满足接口。
// 这是 Go 类型系统的灵魂——接口由使用者定义，而非提供者。

package main

import "fmt"

type Animal interface {
	Speak() string
}

type Dog struct{}

type Cat struct{}

func (Dog) Speak() string { return "woof" }

func (Cat) Speak() string { return "meow" }

func main() {
	animals := []struct {
		name string
		a    Animal
	}{
		{"dog", Dog{}},
		{"cat", Cat{}},
	}
	for _, x := range animals {
		fmt.Printf("%s says: %s\n", x.name, x.a.Speak())
	}
}
