///|
// 全局状态管理
extern "js" fn init_readline() -> Unit =
  #|function() {
  #|  if (!globalThis.readlineState) {
  #|    const { stdin: input, stdout: output } = process;
  #|    input.setEncoding('utf8');
  #|    
  #|    globalThis.readlineState = {
  #|      questionCb: null,
  #|      lineBuf: '',
  #|      isListening: false,
  #|      input,
  #|      output
  #|    };
  #|    
  #|    input.on('data', chunk => {
  #|      const state = globalThis.readlineState;
  #|      state.lineBuf += chunk;
  #|      const idx = state.lineBuf.indexOf('\n');
  #|      if (idx !== -1) {
  #|        const line = state.lineBuf.slice(0, idx).trimEnd();
  #|        state.lineBuf = state.lineBuf.slice(idx + 1);
  #|        if (state.questionCb) {
  #|          const cb = state.questionCb;
  #|          state.questionCb = null;
  #|          cb(line);
  #|        }
  #|      }
  #|    });
  #|  }
  #|}

///|
extern "js" fn question_ffi(
  question : String,
  callback : (String) -> Unit,
) -> Unit =
  #|function(question, callback) {
  #|  if (!globalThis.readlineState) {
  #|    throw new Error('Readline not initialized');
  #|  }
  #|  const state = globalThis.readlineState;
  #|  state.output.write(question);
  #|  state.questionCb = callback;
  #|}

///|
extern "js" fn close_ffi() -> Unit =
  #|function() {
  #|  if (globalThis.readlineState) {
  #|    const state = globalThis.readlineState;
  #|    // 清理回调函数
  #|    state.questionCb = null;
  #|    // 清空缓冲区
  #|    state.lineBuf = '';
  #|    // 移除所有监听器
  #|    state.input.removeAllListeners('data');
  #|    // 暂停输入流
  #|    state.input.pause();
  #|    // 清理全局状态
  #|    delete globalThis.readlineState;
  #|  }
  #|}
