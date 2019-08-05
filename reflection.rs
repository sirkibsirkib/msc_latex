struct TypeInfo(VtablePtr); // VtablePtr field is private. User can only interact with `of` function.
impl TypeInfo {
    pub fn of<T>() -> TypeInfo {
        // 1. fabricate bogus (uninitialized) data pointer to some type T.
        let x: Box<T> = unsafe { MaybeUninit::uninit().assume_init() };
        // 2. SAFE cast to trait object (Rust appends PortDatum vtable pointer for T)
        let fat_x = x as Box<dyn PortDatum>;
        // 3. convert to "raw" dynamic object: a pair of pointers with UNSAFE cast.
        let raw: TraitObject = unsafe { transmute(fat_x) };
        // 4. discard the bogus data. Return wrapped vtable only
        return TypeInfo(raw.vtable)
}   }