struct Foo { val: u32 };
fn func(y: Foo) { // this function moves its parameter into its scope (by value).
}                 // `y` goes out of scope and is (trivially) dropped.
fn main(){
    let x = Foo { val: 5 };
    func(x);      // Ok. `x` is moved into `func`.
    func(x);      // Error! x is used after move.
}