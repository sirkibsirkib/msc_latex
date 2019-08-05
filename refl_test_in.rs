#![feature(raw)]
use std::mem::{MaybeUninit, transmute};
use std::raw::TraitObject;
pub struct TypeInfo(usize);
impl TypeInfo {
    pub fn of<T>() -> TypeInfo {
        let x: Box<T> = unsafe { MaybeUninit::uninit().assume_init() };
        let fat_x = x as Box<dyn PortDatum>;
        let raw: TraitObject = unsafe { transmute(fat_x) };
        TypeInfo(raw.vtable as usize)
}   }
trait PortDatum {
    fn foo(&self) -> u32 { 123 }
}
impl<T> PortDatum for T {}
pub fn test() -> TypeInfo {
    TypeInfo::of::<u32>()
}