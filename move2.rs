struct Foo;
fn func(x: &Foo) {
	// this function borrows some `Foo` structure by reference.
}
fn main(){
	let x = Foo; // instantiate.
	func(&x);     // &x is created in-line. x remains in place.
	func(&x);     // another &x is created. x remains in place.
}