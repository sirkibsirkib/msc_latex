struct Foo;
fn func(x: Foo) {
	// this function takes argument `x` by value.
}
fn main(){
	let x = Foo; // instantiate.
	func(x);     // Ok. `x` is moved into `func`.
	func(x);     // Error! x is used after move.
}