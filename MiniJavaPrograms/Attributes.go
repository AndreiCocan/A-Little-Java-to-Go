package main
import "fmt"

type AI interface{
  draw() int
  init() bool
}

type A struct{
  a int
}

func (this *A) draw() int {
  fmt.Println(this.a)
  return this.a
}

func (this *A) init() bool {
  this.a = 65
  return true
}


type BI interface{
  draw() int
  init() bool
}

type B struct {
  A
  a int
}

func (this *B) draw() int {
  fmt.Println(this.a)
  return this.a
}

func (this *B) init() bool {
  this.a = 66
  return true
}


type CI interface{
  draw() int
  init() bool
}

type C struct {
  B
  a int
}

func (this *C) draw() int {
  fmt.Println(this.a)
  return this.a
}

func (this *C) init() bool {
  this.a = 67
  return true
}


type MainI interface{
  start() int
}

type Main struct{}

func (this *Main) start() int {
  var a AI
  _ = a

  var b AI
  _ = b

  var c AI
  _ = c

  var tmp1 bool
  _ = tmp1

  var tmp2 int
  _ = tmp2

  a = (&A{})
  tmp1 = a.init()
  b = (&B{})
  tmp1 = b.init()
  c = (&C{})
  tmp1 = c.init()
  tmp2 = a.draw()
  tmp2 = b.draw()
  tmp2 = c.draw()
  return 0
}


func main(){
  fmt.Println((&Main{}).start())
}

