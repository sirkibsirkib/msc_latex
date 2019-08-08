// initialization
let barrier_g  = Arc::new(std::sync::Barrier::new(3));
let barrier_p0 = barrier_g.clone();
let barrier_p1 = barrier_g.clone();
let (data_0_s, data_0_r) = crossbeam_channel::bounded(0); // synch  (unbuffered)
let (data_1_s, data_1_r) = crossbeam_channel::bounded(1); // asynch (1-buffered)

// port operation functions
let p0_put_function = || {
	barrier_p0.wait();
	data_0_s.send(P0_VALUE).unwrap();
};
let p1_put_function = || {
	barrier_p1.wait();
	data_1_s.send(P1_VALUE).unwrap();
};
let g_get_function = || {
	barrier_g.wait();
	let value_from_p0 = data_0_r.recv().unwrap();
	let value_from_p1 = data_1_r.recv().unwrap();
};