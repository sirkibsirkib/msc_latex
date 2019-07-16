enum X1 { A, B, C, D }
fn foo1(abcd: X1) {
	match abcd {
		X1::A => { /*A*/ },
		X1::B => { /*B*/ },
		X1::C => { /*C*/ },
		X1::D => { /*D*/ },
}   }


struct StateSet<P> { /*omitted*/ }
type X2 = StateSet<(A, (B, (C, D))>;

fn foo2(abcd: X2) {
	match abcd.match_head() {
		Ok(a) => { /*A*/ },
		Err(bcd) => match bcd.match_head() {
			Ok(b) => { /*B*/ },
			Err(cd) => match cd.match_head() {
				Ok(d) => { /*C*/ },
				Err(d) => { /*D*/ },
}   }   }   }

fn foo2_sugar(abcd: X2) {
	match_list!{abcd;
		a => /*A*/,
		b => /*B*/,
		c => /*C*/,
		d => /*D*/,
	]}
}