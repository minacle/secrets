import ArgumentParser

struct RenameCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "rename",
            abstract: "Rename an existing secret key.",
            discussion:
                """
                Changes the key for an existing secret without changing the stored value.
                """,
        )

    @Argument(
        help: "The current key of the secret to rename.",
    )
    var oldKey: String

    @Argument(
        help: "The new key to assign to the secret.",
    )
    var newKey: String

    func run() throws {
        try rename(oldKey: oldKey, newKey: newKey)
    }
}
