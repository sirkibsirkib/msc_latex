typedef struct DoOne { int n; } DoOne;
typedef struct DoTwo { int n; } DoTwo;
const DoOne START = { .n = 0 };

DoTwo one(DoOne d1) {
	DoTwo d2 = { .n = d1.n + 1};
	return d2;
}
DoOne two(DoTwo d2) {
	DoOne d1 = { .n = d2.n * 2};
	return d1;
}