import Foundation
import PackagePlugin

@main
struct VersionsGeneratorPlugin: BuildToolPlugin {

    func createBuildCommands(
        context: PluginContext,
        target: Target,
    ) async throws -> [Command] {
        [
            .prebuildCommand(
                displayName: "Generating Secrets version",
                executable: context.package.directoryURL
                    .appending(path: "Scripts", directoryHint: .isDirectory)
                    .appending(path: "generate-versions.sh", directoryHint: .notDirectory),
                arguments: [context.pluginWorkDirectoryURL.path],
                environment: [
                    "VG_VERSION": ProcessInfo.processInfo.environment["VG_VERSION", default: ""],
                    "VG_COMMIT": ProcessInfo.processInfo.environment["VG_COMMIT", default: ""],
                ],
                outputFilesDirectory: context.pluginWorkDirectoryURL,
            ),
        ]
    }
}
