import ArgumentParser

struct RenameCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "rename",
        )

    @Argument
    var oldKey: String

    @Argument
    var newKey: String

    func run() throws {
        try rename(oldKey: oldKey, newKey: newKey)
    }
}
