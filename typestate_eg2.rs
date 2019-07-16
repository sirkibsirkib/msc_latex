fn main(d1: DoOne) {
	let d2  = two(d1);
	let d1  = one(d2);
	let d2  = two(d1);
	let d2_again = two(d1); // Error! `d1` has been moved.
}
