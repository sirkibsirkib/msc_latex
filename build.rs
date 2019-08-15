type BuildError = (Option<usize>, BuildErrorInfo);
enum BuildErrorInfo {
    ConflictingMemPremise { name: Ident },
    PutterCannotGet { name: Ident },
    MovementTypeMismatch { getter: Ident, putter: Ident },
    GetterHasMuliplePutters { name: Ident },
    InitialTypeMismatch { name: Name },
    /* 15 more variants */
}
type Ident = &'static str; // static string literal type