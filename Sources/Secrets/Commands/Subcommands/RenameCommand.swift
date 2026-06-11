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

    @Argument
    var oldKey: String

    @Argument
    var newKey: String

    func run() throws {
        try rename(oldKey: oldKey, newKey: newKey)
    }
}
