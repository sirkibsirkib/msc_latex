struct TypeInfo {
    type_id:    TypeId,
    is_copy:    bool,
    layout:     Layout,
    funcs:      TypeInfoFuncs,
}
struct TypeInfoFuncs {
    drop:       Option<fn(Ptr)>,
    clone:      Option<fn(Ptr, Ptr)>,
    partial_eq: Option<fn(Ptr, Ptr)>,
}