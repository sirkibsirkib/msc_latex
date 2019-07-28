enum StateSetXyz { X(X), Y(Z), Z(Z) }
fn match_standard(set_xyz: StateSetXyz) {
    use StateSetXyz::{X, Y, Z};
    match set_xyz {
        X(x) => x.foo(),
        Y(y) => y.bar(),
        Z(z) => z.baz(),    
}   }
fn match_recursive(set_xyz: StateSet<(X, (Y, (Z, ())))>) {
    use StateList::{Head, Tail};
    match set_xyz.match_head() {
        Head(x) => x.foo(),
        Tail(set_yz) => match set_yz.match_head() {
            Head(y) => y.bar(),
            Tail(z) => z.baz(),
}   }   }
fn match_macro(set_xyz: StateSet<(X, (Y, (Z, ())))>) {
    match_set! { set_xyz;
        x => x.foo(),
        y => y.bar(),
        z => z.baz(),    
}   }
