import ArgumentParser

@main
struct SecretsCommand: ParsableCommand {

    static let configuration: CommandConfiguration =
        .init(
            commandName: "secrets",
            subcommands: [
                ReadCommand.self,
                WriteCommand.self,
                RenameCommand.self,
                DeleteCommand.self,
            ]
        )
}
