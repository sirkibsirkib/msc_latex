if want_data {
    let am_mover = mover.swap(false);
    if am_mover {
        if count.sub_fetch(1) == 0 { do_move() }
        else { mover_signal.await() }
        cleanup(was_moved=true);
    } else {
        do_clone();
        if count.sub_fetch(1) == 0 {
            // I was the last cloner. All cloners done.
            mover_signal.release();
    }   }
} else { // want signal only
    if count.sub_fetch(1) == 0 {
        let am_mover = mover.swap(false);
        if am_mover { cleanup(was_moved=false) }
		else { mover_signal.release() }
}   }