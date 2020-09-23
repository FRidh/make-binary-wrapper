# make-binary-wrapper
Tool to generate binary wrappers that wrap executables.

## Usage

```sh
$ make-wrapper --prefix FOO ":" BAR /path/to/my/executable my-new-wrapped
```

## Implementation

The implementation consists of:
1. a Python executable `make-wrapper` that creates a JSON wrapper instruction which then compiles
2. a Nim program that embeds the JSON instruction
