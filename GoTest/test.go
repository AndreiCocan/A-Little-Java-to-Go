package main

import "fmt"

func main() {
    fmt.Println(Main{}.start())
}

type Main struct {}

func (m Main) start() int {
    var a = A{}
    var b A
    var c B
	c = B(c) 
    var tmp1 bool
    var tmp2 int
    tmp1 = a.init()
    tmp1 = b.init()
    tmp1 = c.init()
    tmp2 = a.draw()
    tmp2 = b.draw()
    tmp2 = c.draw()
	fmt.Println(tmp1)
	fmt.Println(tmp2)
    return 0
}

type A struct {
    a int
}

func (a *A) init() bool {
    a.a = 65
    return true
}

func (a *A) draw() int {
    fmt.Println(a.a)
    return a.a
}

type B struct {
    a int
}

func (b *B) init() bool {
    b.a = 66
    return true
}

func (b *B) draw() int {
    fmt.Println(b.a)
    return b.a
}

type C struct {
    B
    a int
}

func (c *C) init() bool {
    c.a = 67
    return true
}

func (c *C) draw() int {
    fmt.Println(c.a)
    return c.a
}
