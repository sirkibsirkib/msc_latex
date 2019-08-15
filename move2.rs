struct Foo { val: u32 };
fn func(y: &Foo) { // this function borrows some `Foo` structure by reference.
}                  // dropping returns the `borrowed' ownership to the caller.
fn main(){
	let x = Foo { val: 5 };
	func(&x);      // &x is created in-line. x remains in place.
	func(&x);      // another &x is created. x remains in place.
}