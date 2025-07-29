# oboard/readline

A readline library for MoonBit

## Features

- 🔄 **Callback-based**: Asynchronous input handling with callback functions
- 🧹 **Resource management**: Proper cleanup with `close()` method
- 📝 **Simple API**: Easy-to-use interface for interactive console applications
- 🚀 **Zero dependencies**: Lightweight implementation using only standard libraries
- 🌐 **Cross-platform**: Works on JavaScript, Native (C) targets

## Installation

Add this package to your MoonBit project:

```bash
moon add oboard/readline
```

## Quick Start

```moonbit
fn main {
  let rl = @readline.new()
  rl.question("What is your name? ", name => {
    println("Hello " + name)
    rl.question("How old are you? ", age => {
      println("You are " + age + " years old")
      rl.close()
    })
  })
}
```

## API Reference

### `new() -> T`

Creates a new readline instance.

```moonbit
let rl = @readline.new()
```

### `T::question(self: T, question: String, callback: (String) -> Unit) -> Unit`

Prompts the user with a question and calls the callback function with the user's input.

**Parameters:**
- `question`: The prompt text to display
- `callback`: Function to handle the user's input

```moonbit
rl.question("Enter your name: ", input => {
  println("You entered: " + input)
})
```

### `T::close(self: T) -> Unit`

Cleans up the readline instance and releases resources.

```moonbit
rl.close()
```

## Platform Support

| Platform | Implementation | Status |
|----------|----------------|--------|
| JavaScript | Browser/Node.js | ✅ Supported |
| Native | C with stdio | ✅ Supported |
| WebAssembly | WASM | ❌ Unsupported |

## Examples

### Simple Q&A

```moonbit
fn main {
  let rl = @readline.new()
  rl.question("What's your favorite color? ", color => {
    println("Nice choice: " + color)
    rl.close()
  })
}
```

### Multiple Questions

```moonbit
fn main {
  let rl = @readline.new()
  rl.question("First name: ", first => {
    rl.question("Last name: ", last => {
      println("Full name: " + first + " " + last)
      rl.close()
    })
  })
}
```

## Building and Testing

## Implementation Details

- **JavaScript**: Uses `prompt()` for browser environments and `readline` module for Node.js
- **Native**: Uses standard C `scanf()` and `printf()` functions

## License

Apache-2.0

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## Changelog

### v0.1.0
- Initial release
- Cross-platform readline support
- Basic question/answer functionality
- Resource cleanup with close() method