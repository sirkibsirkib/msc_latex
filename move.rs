struct Foo;
fn func(x: Foo) { // this function moves its argument into its scope (by value).
}                 // `x` goes out of scope and is (trivially) dropped.

fn main(){
    let x = Foo;  // (trivial) initialization.
    func(x);      // Ok. `x` is moved into `func`.
    func(x);      // Error! x is used after move.
}