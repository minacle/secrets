import ArgumentParser

struct ReadCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "read",
        )

    @Argument
    var key: String

    func run() throws {
        try print(read(key: key))
    }
}
