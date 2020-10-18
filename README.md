# make-binary-wrapper
Tool to generate binary wrappers that wrap executables.

## Motivation

In [Nixpkgs](https://github.com/NixOS/nixpkgs) we often need to wrap
executables. Included in Nixpkgs is the `makeWrapper` bash script for creating
shell wrappers. This typically suffices, but not always. On macOS shebangs can't
point at interpreted (shebang'd) scripts. Having a binary wrapper (in between)
resolves this issue.

## Usage

```sh
$ make-wrapper --prefix FOO ":" BAR /path/to/my/executable my-new-wrapped
```

## Implementation

The implementation consists of:
1. a Python executable `make-wrapper` that creates a JSON wrapper instruction
   which then compiles
2. a Nim program that embeds the JSON instruction

## File size

The resulting wrappers are approximately 79 kB in size.

## Alternative approaches

Some alternatives were considered.

### Shell wrappers

As explained in the motivation, the `makeWrapper` script part of Nixpkgs does
not suffice on macOS.

### Single JSON instruction for many executables

Instead of creating a JSON instruction per executable, one could have a single
JSON file for all executables in an executable, and have the wrappers read that
shared JSON file.

This approach is simpler to implement, however, it would be a very
Nixpkgs-specific solution.
