struct DivZeroError;  // contains no data

fn divide_by(numerator: f32, divisor: f32) -> Result<f32, DivZeroError> {
    if divisor == 0. {
        Result::Err(DivZeroError)
    } else {
        Result::Ok(numerator / divisor)
}   }

fn main(input: f32) {
    match divide_by(4.5, input) {
        Ok(x) => print!("Success! computed:{}.", x),
        Err(_) => print!("Something went wrong!"),
}   }