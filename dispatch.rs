trait Emits {
    fn emit(&self) -> usize;
}
impl Emits for String {
    fn emit(&self) -> usize {
        self.len()
    }
}
fn func_static<T: Emits>(x: &T) -> bool {
	x.emit() > 10
}
fn func_dynamic(x: &dyn Emits) -> bool {
    x.emit() > 10
}
fn main() {
	let value = String::from("Hello!");
	func_static::<String>(&value);
	func_dynamic(&value as &dyn Emits);
}