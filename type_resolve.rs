fn new_protocol_a() -> ProtoDef {
    ProtoDef {
        name_defs: hashmap! { "A" => Memory(TypeInfo::of::<String>) },
        rules: vec![],
}   }
fn main_a() {
    let _ = protocol_0();
}

fn new_protocol_b<T>() -> ProtoDef {
    ProtoDef {
        name_defs: hashmap! { "A" => Memory(TypeInfo::of::<T>) },
        rules: vec![],
}   }
fn main_b() {
    let _ = protocol_1::<String>();
    let _ = protocol_1::<Bar>();
    let _ = protocol_1::<Foo>();
}