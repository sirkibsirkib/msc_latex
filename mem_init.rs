fn new_protocol<T: From<&str>>() -> ProtoHandle {
    ProtoDef {
        name_defs: hashmap! { "A" => Memory(TypeInfo::of::<T>) },
        rules: vec![],
    }.build(MemInit::default().with<T>("hello".into())).unwrap()
}
fn main() {
    let _ = new_protocol::<String>();
}