fn def_async_transform<T>(f: fn(&T)->T) -> Proto {
    ProtoDef {
        name_defs: {
            "A"   => Port(Putter, T),
            "B"   => Port(Getter, T),
            "mem" => Memo(Uninit, T),
            "f"   => Func(FuncHandle::new(f)),
        },
        rules: [
            RuleDef {
                premise: Premise {
                    ready_ports: {"A"},
                    full_mem:    {},
                    empty_mem:   {"mem"},
                },
                instructions: [],
                movements: { "A" => {"mem"} }
            },
            RuleDef {
                premise: Premise {
                    ready_ports: {"B"},
                    full_mem:    {"mem"},
                    empty_mem:   {},
                },
                instructions: [
                    CreateFromFunc("temp", "f", [Resource("mem")]),
                ],
                movements: { "temp" => {"B"} }
            }
        ],
    }.build(MemInitial::empty())
}