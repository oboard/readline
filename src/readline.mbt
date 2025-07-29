///|
type T Unit

///|
pub fn new() -> T {
  init_readline()
}

///|
pub fn T::question(
  self : T,
  question : String,
  callback : (String) -> Unit,
) -> Unit {
  question_ffi(question, input => callback(input))
}

///|
pub fn T::close(self : T) -> Unit {
  close_ffi()
}

///|
test {
  let rl = new()
  rl.question("What is your name? ", name => {
    println("Hello " + name)
    rl.question("How old are you? ", age => {
      println("You are " + age + " years old")
      // 清理readline状态
      rl.close()
      println("Readline closed.")
    })
  })
}
