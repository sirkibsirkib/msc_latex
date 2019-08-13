fn build_protocol_1<T: Clone>() -> Proto {
    ProtoDef {
        let type_info = TypeInfo::of::<T>();
        name_defs: hashmap! {
            "P" => Port { is_putter:true, type_info },
            "C0" => Port { is_putter:false, type_info },
            "C1" => Port { is_putter:false, type_info },
        },
        rules: vec![RuleDef {
            state_guard: StatePredicate {
                ready_ports: hashset! {"P", "C0", "C1"},
                full_mem: hashset! {},
                empty_mem: hashset! {},
            },
            ins: vec![],
            output: hashmap! {
                "P" => (false, hashset!{"C0", "C1"}),
            },
        }],
    }.build(MemInitial::default()).unwrap()
}