let p: &ProtoHandle = /* omitted */;
type T = 'static str;

let port_3: Putter<T> = p.claim(3).try_into().unwrap();
port_3.put("first value"));
drop(port_3); // destroys port_3. It is no longer claimed.

let port_3: Putter<T> = p.claim(3).try_into().unwrap();
port_3.put("second value"));

let port_3: Putter<T> = p.claim(3).try_into().unwrap();
// Error! claim returned `ClaimResult::NotUnclaimed`
