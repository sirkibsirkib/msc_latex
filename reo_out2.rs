lazy_static! {
    static ref MY_PROTO: ProtoDef = ProtoDef {
        name_defs: {
            "P0"   => Port(Putter, u32),
            "P1"   => Port(Putter, u32),
            "C"    => Port(Getter, u32),
            "f"    => Func(FuncHandle::new(|x: *const u32| *x + 1)),
        },
        rules: [
            RuleDef {
                premise: Premise {
                    ready_ports: {"P0", "P1", "C"},
                    full_mem:    {},
                    empty_mem:   {},
                },
                instructions: [
                    CreateFromFunc("t0", "f", [Resource("P0")]),
                    CreateFromFunc("t1", "f", [Resource("P1")]),
                    Check(IsEq([Resource("T0"), Resource("T1")])),
                ],
                movements: { "t0" => {"C"} }
            }
        ],
    }
}