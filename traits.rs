pub fn something<T>(val: &T) where T: PrintsBool {
    val.greet()
}
trait Greets {
    fn greet(&self);
}
impl Greets for String {
    fn greet(&self) {
        println!("hello!")
}   }
