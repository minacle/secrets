# Secrets

Secrets is a Swift command-line tool that stores secret values as generic password items in the macOS Keychain under the `moe.minacle.secrets` service. It requires macOS 13 or later.

## Installation

Download the signed and notarized universal `secrets.pkg` from [GitHub Releases](https://github.com/minacle/secrets/releases). It supports Apple silicon and Intel Macs and installs `secrets` at `/usr/local/bin/secrets`.

```sh
sudo installer -pkg secrets.pkg -target /
```

To build from source with Swift 6.3.3:

```sh
swift build -c release
```

The binary is written to `.build/release/secrets`.

## Usage

```sh
secrets write <key> <value>
secrets read <key>
secrets rename <old-key> <new-key>
secrets delete <key>
secrets --version
```

`write` replaces an existing value for the same key. `read` prints the stored value to standard output, and `rename` changes only the key.
