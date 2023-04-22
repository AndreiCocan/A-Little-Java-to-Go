package main
import "fmt"

type CircleI interface{
  draw() int
  init() int
}

type Circle struct {
  Shape}

func (this *Circle) draw() int {
  fmt.Println(102)
  return 0
}


type RectangleI interface{
  draw() int
  init() int
}

type Rectangle struct {
  Shape}

func (this *Rectangle) draw() int {
  fmt.Println(101)
  return 0
}


type ShapeI interface{
  draw() int
  init() int
}

type Shape struct{}

func (this *Shape) draw() int {
  fmt.Println(100)
  return 0
}

func (this *Shape) init() int {
  var c CircleI
  _ = c

  var r RectangleI
  _ = r

  var s ShapeI
  _ = s

  var tmp int
  _ = tmp

  s = (&Shape{})
  r = (&Rectangle{})
  c = (&Circle{})
  tmp = s.draw()
  tmp = r.draw()
  tmp = c.draw()
  s = r
  tmp = s.draw()
  s = c
  tmp = s.draw()
  return 0
}


func main(){
  fmt.Println((&Shape{}).init())
}

