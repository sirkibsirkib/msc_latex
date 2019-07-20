pub struct Proto {
    cr: Mutex<ProtoCr>, // accessed by coordinator with lock
    r: ProtoR, // shared access
}
struct ProtoR {
    rules: Vec<Rule>,
    spaces: Vec<Space>,
    name_mapping: Map<Name, LocId>,
    port_info: HashMap<LocId, (IsPutter, TypeInfo)>,
}
struct ProtoCr {
    unclaimed: HashSet<LocId>,
    is_ready: BitSet,
    memcell_state: BitSet, // presence means mem is FULL
    allocator: Allocator,
    ref_counts: HashMap<Ptr, usize>,
}