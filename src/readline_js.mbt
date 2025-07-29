///|
// Global state management
extern "js" fn init_readline() -> Unit =
  #|function() {
  #|  if (!globalThis.readlineState) {
  #|    // Detect environment: browser vs Node.js
  #|    const isBrowser = typeof window !== 'undefined' && typeof process === 'undefined';
  #|    
  #|    if (isBrowser) {
  #|      // Browser environment - use prompt()
  #|      globalThis.readlineState = {
  #|        isBrowser: true,
  #|        questionCb: null
  #|      };
  #|    } else {
  #|      // Node.js environment - use stdin/stdout
  #|      const { stdin: input, stdout: output } = process;
  #|      input.setEncoding('utf8');
  #|      
  #|      globalThis.readlineState = {
  #|        isBrowser: false,
  #|        questionCb: null,
  #|        lineBuf: '',
  #|        isListening: false,
  #|        input,
  #|        output
  #|      };
  #|      
  #|      input.on('data', chunk => {
  #|        const state = globalThis.readlineState;
  #|        state.lineBuf += chunk;
  #|        const idx = state.lineBuf.indexOf('\n');
  #|        if (idx !== -1) {
  #|          const line = state.lineBuf.slice(0, idx).trimEnd();
  #|          state.lineBuf = state.lineBuf.slice(idx + 1);
  #|          if (state.questionCb) {
  #|            const cb = state.questionCb;
  #|            state.questionCb = null;
  #|            cb(line);
  #|          }
  #|        }
  #|      });
  #|    }
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
  #|  
  #|  if (state.isBrowser) {
  #|    // Browser environment - use prompt()
  #|    const result = prompt(question);
  #|    callback(result || '');
  #|  } else {
  #|    // Node.js environment - use stdin/stdout
  #|    state.output.write(question);
  #|    state.questionCb = callback;
  #|  }
  #|}

///|
extern "js" fn close_ffi() -> Unit =
  #|function() {
  #|  if (globalThis.readlineState) {
  #|    const state = globalThis.readlineState;
  #|    
  #|    if (state.isBrowser) {
  #|      // Browser environment - simple cleanup
  #|      state.questionCb = null;
  #|    } else {
  #|      // Node.js environment - full cleanup
  #|      state.questionCb = null;
  #|      state.lineBuf = '';
  #|      state.input.removeAllListeners('data');
  #|      state.input.pause();
  #|    }
  #|    
  #|    // Clean up global state
  #|    delete globalThis.readlineState;
  #|  }
  #|}
