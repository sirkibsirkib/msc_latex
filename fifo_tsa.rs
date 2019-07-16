enum E {} // E for "Empty"
enum F {} // F for "Full"
fn start_state() -> (E,E);

fn a_to_m0<M>(state: (E,M)) -> (F,M);
fn m0_to_m1  (state: (F,E)) -> (E,F);
fn m1_to_b<M>(state: (M,F)) -> (M,E);