if T::IS_COPY { // irrelevant how many copy
    if let Some(dest) = maybe_dest {
        do_move(dest);
        m.visit();
    }
    let was = count.fetch_dec();
    if was == LAST {
        let [visited_first, retains] = m.visit();
        finalize();
    }
} else {
    if let Some(dest) = maybe_dest {
        let [visited_first, retains] = m.visit();
        if visited_first && !retains {
            let was = count.fetch_dec();
            if was != LAST {
                mover_await();
            }
            do_move(dest);
            finalize();
        } else {
            do_clone(dest);
            let was = count.fetch_dec();
            if was == LAST {
                if retains {
                    finalize();
                } else {
                    mover_release();
        }   }   }
    } else {
        let was = count.fetch_dec();
        if was == LAST {
            let [visited_first, retains] = m.visit();
            if visited_first {
                finalize();
            } else {
                mover_release();
}   }   }   }