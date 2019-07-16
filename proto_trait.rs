struct TypelessProtoDef {
    behaviour: BehaviourDef,
    loc_kind_ext: HashMap<LocId, LocKind>,
}
trait Proto {	
    fn typeless_proto_def() -> &'static TypelessProtoDef;
    fn loc_type(loc_id: LocId) -> Option<TypeInfo>;
    fn fill_memory(LocId, MemFillPromise) -> Option<Fulfilled>;
    fn instantiate() -> Arc<ProtoAll> {
        // default body omitted //
    }
}