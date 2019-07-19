pub fn something<T: PrintsBool>() {
    T::print(true);
}
trait PrintsBool {
    fn print(bool);
}
impl PrintsBool for String {
    fn print(b: bool) {
        println!("bool is: {}", b)
}   }
