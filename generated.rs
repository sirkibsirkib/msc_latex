use reo_rs::*;
fn instantiate<T: FromStr>() -> ProtoHandle {
    let type_info = TypeInfo::of::<T>();
    let mem_init = MemInitial::default().with("m", "VALUE".from_str())
    let proto_def = ProtoDef {
        name_defs: {
            "A"   => Port { putter: true,  type_info },
            "B"   => Port { putter: false, type_info },
            "m" => Memo(type_info),
        },
        rules: [
            RuleDef {
                premise: Premise {
                    ready_ports: {"A"},
                    full_mem:    {   },
                    empty_mem:   {"m"},
                },
                instructions: [],
                movements: { "A" => {"m"} }
            },
            RuleDef {
                premise: Premise {
                    ready_ports: {"B"},
                    full_mem:    {"m"},
                    empty_mem:   {   },
                },
                instructions: [],
                movements: { "m" => {"B"} }
            }
        ],
    };
    let built_proto = proto_def.build(mem_init).unwrap();
    return built_proto;
}