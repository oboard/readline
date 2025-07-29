#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_INPUT_SIZE 1024

// Global state management
static int readline_initialized = 0;

// Initialize readline
void init_readline_internal() {
    if (!readline_initialized) {
        readline_initialized = 1;
    }
}

// Question function with input handling
char *question_ffi_internal(char *question) {
    static char buffer[MAX_INPUT_SIZE];
    
    if (!readline_initialized) {
        init_readline_internal();
    }
    
    // Output question prompt
    printf("%s", question);
    fflush(stdout);
    
    // Read user input (including spaces)
    if (fgets(buffer, MAX_INPUT_SIZE, stdin) != NULL) {
        // Remove trailing newline if present
        size_t len = strlen(buffer);
        if (len > 0 && buffer[len - 1] == '\n') {
            buffer[len - 1] = '\0';
        }
        return buffer;
    } else {
        // Handle EOF or error cases
        buffer[0] = '\0';
        return buffer;
    }
}

// Clean up readline state
void close_ffi_internal() {
    if (readline_initialized) {
        readline_initialized = 0;
        fflush(stdin);
    }
}