// swift-tools-version: 6.3

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .defaultIsolation(nil),
    .strictMemorySafety(),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("ImmutableWeakCaptures"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
]

let package = Package(
    name: "Secrets",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(
            name: "secrets",
            targets: ["Secrets"],
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.8.2",
        ),
    ],
    targets: [
        .executableTarget(
            name: "Secrets",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser",
                ),
            ],
            swiftSettings: swiftSettings,
            plugins: ["SecretsVersionsGeneratorPlugin"],
        ),
        .testTarget(
            name: "SecretsTests",
            dependencies: ["Secrets"],
            swiftSettings: swiftSettings,
        ),
        .plugin(
            name: "SecretsVersionsGeneratorPlugin",
            capability: .buildTool(),
            path: "Plugins/VersionsGeneratorPlugin",
        ),
    ],
    swiftLanguageModes: [.v6],
)
