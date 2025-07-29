///|
fn init_readline() -> Unit {
  init_readline_internal()
}

///|
fn question_ffi(question : String, callback : (String) -> Unit) -> Unit {
  let bytes = @encoding.encode(question, encoding=UTF8)
  let question_c = @native.unsafe_coerce(bytes)
  let result_ptr = question_ffi_internal(question_c)
  let result_bytes = @native.CStr::unsafe_from_byte_ptr(result_ptr).to_bytes()[0:-1] // 去除 \u{00}
  // 去除末尾的 null 字符
  if (try? @encoding.decode(result_bytes, encoding=UTF8)) is Ok(text) {
    callback(text)
  } else {
    callback("")
  }
  @native.free(question_c)
  @native.free(result_ptr)
}

///|
fn close_ffi() -> Unit {
  close_ffi_internal()
}

///|
extern "c" fn init_readline_internal() -> Unit = "init_readline_internal"

///|
extern "c" fn question_ffi_internal(
  question : @native.Ptr[Byte],
) -> @native.Ptr[Byte] = "question_ffi_internal"

///|
extern "c" fn close_ffi_internal() -> Unit = "close_ffi_internal"
