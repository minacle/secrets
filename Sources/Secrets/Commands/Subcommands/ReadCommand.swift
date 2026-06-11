import ArgumentParser

struct ReadCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "read",
            abstract: "Read a secret value from the macOS Keychain.",
            discussion:
                """
                Looks up the secret stored for the given key and prints its value to standard output.
                """,
        )

    @Argument
    var key: String

    func run() throws {
        try print(read(key: key))
    }
}
