import ArgumentParser

@main
struct SecretsCommand: ParsableCommand {

    static let configuration: CommandConfiguration =
        .init(
            commandName: "secrets",
            abstract: "Store and manage secrets in the macOS Keychain.",
            discussion:
                """
                Secrets stores values as generic password items in the macOS Keychain.
                Use the read, write, rename, and delete subcommands to manage values by key.
                """,
            subcommands: [
                ReadCommand.self,
                WriteCommand.self,
                RenameCommand.self,
                DeleteCommand.self,
            ]
        )
}
