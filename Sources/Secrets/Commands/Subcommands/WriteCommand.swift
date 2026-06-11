import ArgumentParser

struct WriteCommand: ParsableCommand {
    static let configuration: CommandConfiguration =
        .init(
            commandName: "write",
        )

    @Argument
    var key: String

    @Argument
    var value: String

    func run() throws {
        try write(key: key, value: value)
    }
}
