struct TypeInfo(VtablePtr); // VtablePtr field is private (opaque to user).
impl TypeInfo {
    fn of<T: PortDatum>() -> TypeInfo {
        // 1. fabricate bogus (uninitialized) data pointer to some type T.
        let x: Box<T> = unsafe { MaybeUninit::zeroed().assume_init() };
        // 2. SAFE cast to trait object (Rust appends vtable pointer)
        let fat_x = x as Box<dyn PortDatum>;
        // 3. convert to "raw" trait object: a pair of pointers with UNSAFE cast.
        let raw: TraitObject = unsafe { transmute(fat_x) };
        // 4. discard the bogus data. Return wrapped vtable only
        TypeInfo(raw.vtable)
}   }