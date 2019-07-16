fn normalize(mut rules: Set<Rule>) -> Set<Rule> {
    let (mut silents, mut not_silents) = rules.partition_by(Rule::is_silent);
    while silents.not_empty() {
        let removing: Rule = silents.remove();
        if removing.changes_configuration() {        
            for r in silents.iter() {
                if let Some(c) = removing.try_compose_with(r) {
                    silents.insert(c);
            }   }
            for r in not_silents.iter() {
                if let Some(c) = removing.try_compose_with(r) {
                    not_silents.insert(c);
    }   }   }   }
    return not_silents;
}