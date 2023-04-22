package main
import "fmt"

type AI interface{
  get() * A
  init() int
  print() int
}

type A struct{
  a int
}

func (this *A) get() * A {
  return (&A{})
}

func (this *A) init() int {
  var a AI
  _ = a

  var b AI
  _ = b

  var c AI
  _ = c

  var tmp int
  _ = tmp

  a = (&A{}).get()
  b = (&B{}).get()
  c = (&C{}).get()
  tmp = a.print()
  tmp = b.print()
  tmp = c.print()
  return 0
}

func (this *A) print() int {
  fmt.Println(65)
  return 65
}


type BI interface{
  get() * B
  init() int
  print() int
}

type B struct {
  A}

func (this *B) get() * B {
  return (&B{})
}

func (this *B) print() int {
  fmt.Println(66)
  return 66
}


type CI interface{
  get() * C
  print() int
}

type C struct {
  B}

func (this *C) get() * C {
  return (&C{})
}

func (this *C) print() int {
  fmt.Println(67)
  return 67
}


func main(){
  fmt.Println((&A{}).init())
}

