fn putter_0_work<T>(P0_VALUE: T) {
	all_barrier.wait();
	rendezvous_data.send(P0_VALUE);
}
fn putter_1_work<T>(P1_VALUE: T) {
	all_barrier.wait();
	buffered_data.send(P1_VALUE);
}
fn getter_work() -> (T,T) {
	all_barrier.wait();
	let P0_VALUE = rendezvous_data.recv();
	let P1_VALUE = buffered_data.recv();
	(P0_VALUE, P1_VALUE)
}