import ArgumentParser

struct WriteCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "write",
            abstract: "Write a secret value to the macOS Keychain.",
            discussion:
                """
                Stores the value for the given key. If the key already exists, its value is replaced.
                """,
        )

    @Argument
    var key: String

    @Argument
    var value: String

    func run() throws {
        try write(key: key, value: value)
    }
}
