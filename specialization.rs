trait MaybeCopy { // private helper trait
    const IS_COPY: bool = false;
}
impl<T> MaybeCopy for T {} // default case. NOT COPY
impl<T: Copy> MaybeCopy for T { // specialize for COPY TYPES
    const IS_COPY: bool = true;
}
/////////////////////////////////////////////////////////////////////
trait MaybeEq { // private helper trait
    fn maybe_eq(&self, _: &Self) -> bool {
        panic!("This type cannot check equality!")
}   }
impl<T> MaybeEq for T {} // default case. NOT PartialEq
impl<T: Eq> MaybeEq for T {
    fn maybe_eq(&self, other: &Self) -> bool {
        return self == other
}   }
/////////////////////////////////////////////////////////////////////
trait PortDatum { // main PortDatum trait. also private
    fn is_copy(&self) -> bool;
    fn eq(&self, other: &Self) -> bool;
}
impl<T> PortDatum for T {
    fn is_copy(&self) -> bool {
        <Self as MaybeCopy>::IS_COPY
    }
    fn eq(&self, other: &Self) -> bool {
        <Self as MaybeEq>::maybe_eq(self, other)
}   }
