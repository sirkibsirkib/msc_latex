pub struct Rule {
    bit_guard: BitStatePredicate,
    ins: Vec<Instruction>,
    movement: Map<LocId, Vec<LocId>>,
    bit_assign: BitStatePredicate,
}
struct BitStatePredicate {
    ready: BitSet,
    full_mem: BitSet,
    empty_mem: BitSet,
}
enum Instruction {
    CreateFromFormula { dest: LocId, term: Term },
    CreateFromCall { dest: LocId, func: CallHandle, args: Vec<Term> },
    Check(Term),
    MemSwap(LocId, LocId),
}
enum Term {
    True,
    And(Vec<Term>),
    Load(LocId),
	... // omitted
}