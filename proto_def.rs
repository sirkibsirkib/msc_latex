struct ProtoDef {
    name_defs: Map<Name, NameDef>,
    rules: Vec<RuleDef>,
}
type IsPutter = bool;
enum NameDef {
    Port(IsPutter, TypeInfo),
    Mem(TypeInfo),
    Func(CallHandle),
}
type Retains = bool;
struct RuleDef {
    state_guard: StatePredicate,
    ins: Vec<Instruction>,
    output: HashMap<Name, (Retains, HashSet<Name>)>,
}
struct StatePredicate {
    ready_ports: HashSet<Name>,
    full_mem: HashSet<Name>,
    empty_mem: HashSet<Name>,
}
enum Term {
    True,
    False,
    Not(Box<Self>),
    And(Vec<Self>), 
    Or(Vec<Self>), 
    BoolCall { func: Name, args: Vec<Term> },
    IsEq(TypeInfo, Box<(Self, Self)>),  
    Named(Name), 
}
enum Instruction {
    CreateFromFormula(Name, Term),
    CreateFromCall { info: TypeInfo, dest: Name, func: Name, args: Vec<Term> },
    Check(Term),
    MemSwap(Name, Name),
}