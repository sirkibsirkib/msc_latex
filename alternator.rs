struct Alternator<T> where T: 'static;
impl<T> Proto for Alternator<T> where T: 'static {
    fn typeless_proto_def() -> &'static TypelessProtoDef {
        lazy_static! TypelessProtoDef {
            behaviour: BehaviourDef [
                rule![Formula::True; 0=>2; 1=>3],
                rule![Formula::True; 3=>2],
            ],
            loc_kinds: map! {
                0 => LocKind::PortPutter,
                1 => LocKind::PortPutter,
                2 => LocKind::PortGetter,
                3 => LocKind::MemUninitialized,
    }   }   }
    fn fill_memory(_loc_id: LocId, _p: MemFillPromise) -> Option<Fulfilled> {
        None
    }
    fn loc_type(loc_id: LocId) -> Option<TypeInfo> {
        match loc_id {
            0..=3 => Some(TypeInfo::new::<T>()),
            _     => None,
}   }   }