package main
import "fmt"

type Circle struct {
  *Shape
  

}

func (this *Circle) draw() int {
  fmt.Println(102)
  return 0
}


type Rectangle struct {
  *Shape
  

}

func (this *Rectangle) draw() int {
  fmt.Println(101)
  return 0
}


type Shape struct{
}

func (this *Shape) draw() int {
  fmt.Println(100)
  return 0
}

func (this *Shape) init() int {
  var c * Circle
  _ = c

  var r * Rectangle
  _ = r

  var s * Shape
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

