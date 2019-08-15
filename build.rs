fn build(&ProtoDef, MemInitial) -> Result<ProtoHandle, BuildError>;

type BuildError = (Option<usize>, BuildErrorInfo);
enum BuildErrorInfo {
    MovementTypeMismatch     { getter: Ident, putter: Ident },
    ConflictingMemPremise    { name: Ident },
    PutterCannotGet          { name: Ident },
    GetterHasMuliplePutters  { name: Ident },
    InitialTypeMismatch      { name: Ident },
    GetterHasMultiplePutters { name: Name },
    EqForDifferentTypes,
    CheckingNonBoolType,
    /* 12 more variants */
}
type Ident = &'static str; // static string literal type