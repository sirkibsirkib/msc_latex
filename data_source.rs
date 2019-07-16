trait DataSource {    
    fn finalize(&self, someone_moved: bool) {
        // Omitted. signal getter OR empty memory cell.
    }
    fn get_datum(&self, dest: Ptr, meta: MetaMsg) {
        // dest points to the getter's uninitialized Datum.
        if space.type_info.always_copy {
            // special case. Type implements Copy. Safe to copy in parallel.
            self.type_info.copy(self.src, dest);    
            let idx = self.atomic_counter.fetch_sub(1);    
            if idx == meta.last_idx() {    
                self.finalize(true);    
            }    
        } else {
            if meta.i_must_move() {    
                if meta.mover_must_wait() {    
                    space.mover_wait();    
                }    
                self.type_info.copy(self.src, dest);    
                self.finalize(true);    
            } else { // I must clone.
                space.type_info.clone(self.src, dest);    
                let idx = space.atomic_counter.fetch_sub(1);    
                if idx == meta.last_idx() {    
                    if meta.someone_moves() {    
                        space.mover_notify();    
                    } else {    
                        self.finalize(false);    
}   }   }   }   }   }