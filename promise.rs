struct Promise;
struct Fulfilled;

fn fulfill(p: Promise) -> Fulfilled {
	// invoked once per `main`
	return Fulfilled::new();
}

fn main(callback: fn(Promise)->Fulfilled) {
	// ...
	let _ = callback(Promise::new()); // `Fulfilled` discarded.
	// ...
}