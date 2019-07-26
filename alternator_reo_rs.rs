fn build_alternator() -> Proto {
    let type_info = TypeInfo::of::<'static str>();
    ProtoDef {
        name_defs: hashmap! {
            "P0" => NameDef::Port { is_putter:true, type_info },
            "P1" => NameDef::Port { is_putter:true, type_info },
            "G" => NameDef::Port { is_putter:false, type_info },
            "M" => NameDef::Mem(type_info),
        },
        rules: vec![
            RuleDef {
                state_guard: StatePredicate {
                    ready_ports: hashset! {"P0", "P1", "G"},
                    full_mem: hashset! {},
                    empty_mem: hashset! {"M"},
                },
                ins: vec![],
                output: hashmap! {
                    "P0" => (false, hashset!{"G"}),
                    "P1" => (false, hashset!{"M"}),
                },
            },
            RuleDef {
                state_guard: StatePredicate {
                    ready_ports: hashset! {"G"},
                    full_mem: hashset! {"M"},
                    empty_mem: hashset! {},
                },
                ins: vec![],
                output: hashmap! {
                    "M" => (false, hashset!{"G"}),
                },
            },
        ],
    }.build(MemInitial::default()).unwrap()
}