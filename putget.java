void stateA() {
	this.value = get();
	if (this.value == 3) {
		stateB();
	} else {
		stateA();
	}
}
void stateB() {
	put(this.value);
	stateA();
}