fn new_protocol<T: Eq>() -> ProtoDef {
    ProtoDef {
        name_defs: hashmap! {
            "A" => Memory(TypeInfo::of::<T>),
            "B" => Memory(TypeInfo::of::<T>),
        },
        rules: vec![
            premise:   /* omitted */,
            instructions: vec![Check(Eq("A", "B"))],
            movements: /* omitted */,
        ],
}   }
fn main() {
    let _ = new_protocol::<String>(); // ok! String implements Eq
    struct Foo;
    let _ = new_protocol::<Foo>(); // ERROR! Foo does not implement Eq!
}