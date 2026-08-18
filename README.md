# Secrets

Secrets is a small Swift command-line tool for storing and managing secret values in the macOS Keychain.

Values are stored as generic password items under the `moe.minacle.secrets` Keychain service.

## Requirements

- macOS 13 or later

## Installation

Download the installer package for your Mac from
[GitHub Releases](https://github.com/minacle/secrets/releases):

| Package | Mac |
| --- | --- |
| `secrets.pkg` | Apple silicon and Intel |

The signed and notarized package installs `secrets` at `/usr/local/bin/secrets`.
Open the package in Finder, or install it from Terminal:

```sh
sudo installer -pkg secrets.pkg -target /
```

To build from source, install Swift 6.3.3 and run:

```sh
swift build -c release
```

The compiled binary is available at:

```sh
.build/release/secrets
```

Exact release tags report their version through `secrets --version`.
Development builds report `dev+<short-commit>`.

## Usage

```sh
secrets <subcommand>
```

### Write a secret

```sh
secrets write <key> <value>
```

Writes a value for `key`. If the key already exists, the stored value is replaced.

### Read a secret

```sh
secrets read <key>
```

Prints the value stored for `key`.

### Rename a secret

```sh
secrets rename <old-key> <new-key>
```

Renames an existing key without changing its stored value.

### Delete a secret

```sh
secrets delete <key>
```

Deletes the value stored for `key`.

## Examples

```sh
secrets write api-token "secret-value"
secrets read api-token
secrets rename api-token production-api-token
secrets delete production-api-token
```
