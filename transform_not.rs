fn transform_not(p: Putter<bool>, g: Getter<bool>) {
    loop {
        let input: bool = g.get();
        print!("I saw {}.", input);
        p.put(! input);
}   }