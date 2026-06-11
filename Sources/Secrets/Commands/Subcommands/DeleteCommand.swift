import ArgumentParser

struct DeleteCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "delete",
        )

    @Argument
    var key: String

    func run() throws {
        try delete(key: key)
    }
}
