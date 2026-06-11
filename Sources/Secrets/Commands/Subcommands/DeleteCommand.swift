import ArgumentParser

struct DeleteCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "delete",
            abstract: "Delete a secret from the macOS Keychain.",
            discussion:
                """
                Removes the secret stored for the given key.
                """,
        )

    @Argument
    var key: String

    func run() throws {
        try delete(key: key)
    }
}
