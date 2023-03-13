struct Aw {
pub mut:
  a int

}
fn (this Aw) draw() int {
  println(this.a)
  return this.a
}
fn (mut this Aw) init() bool {
  this.a = 65
  return true
}

struct Bw {
  Aw
pub mut:
  a int

}

fn main(){
  mut a := Aw{}
  a = Bw(a)
  println(a)
}