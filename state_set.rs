trait StateSetMatch {
    type MatchResult;
    fn match_head(self) -> Self::MatchResult;
}
struct StateSet<L> { data: /* omitted */ }
impl<H,Ta,Tb> StateSetMatch for StateSet<(State<H>, (Ta, Tb))> { 
// a list with 2+ elements. match_head definition omitted
    type MatchResult = Result(State<H>, StateSet<(Ta,Tb)>>;
}
impl<S> StateSetMatch for StateSet<(State<S>, ())> {
// singleton set. `()` acts as a sentinel element. match_head definition omitted
    type MatchResult = State<S>;
}
fn example(ab_set: StateSet<(State<A>, (State<B>, ()))>) {
    match ab_set.match_head() {
        Ok(a) => /* matched A */,
        Err(b_set) => {
            let b = b_set.match_head();
            /* matched B */
}   }   } 