package main
import "fmt"

type FacI interface{
  computeFac(num int) int
}

type Fac struct{}

func (this *Fac) computeFac(num int) int {
  var numAux int
  _ = numAux

  if num < 1 {
    numAux = 1
  } else {
    numAux = num * this.computeFac(num - 1)
  }
  return numAux
}


func main(){
  fmt.Println((&Fac{}).computeFac(10))
}

