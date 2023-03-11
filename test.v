struct Main {

}
fn (m Main) createarray(n int) []int {

  mut a := []int{}
  mut i := 0
  a = []int{len: n, init: 0}
  println(a)
  i = 0
  for i < n {
    a[i] = i
    i = i + 1
  }
  return a
}

fn (m Main) init() []int {

  return m.createarray(42)
}

fn main(){
  println(Main{}.init())
}
