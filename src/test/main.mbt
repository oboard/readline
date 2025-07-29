///|
fn main {
  let rl = @readline.new()
  rl.question("What is your name: ", input => {
    println("Your name is: " + input)
    rl.question("What is your age: ", input => {
      println("Your age is: " + input)
      rl.close()
    })
  })
}
