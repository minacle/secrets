extension Versions {

    static nonisolated var current: String {
        current(tag: tag, commit: commit)
    }

    static nonisolated func current(tag: String, commit: String) -> String {
        if let release = releaseVersion(from: tag) {
            return release
        }
        guard !commit.isEmpty else {
            return "dev"
        }
        return "dev+\(commit.prefix(7))"
    }

    private static nonisolated func releaseVersion(from value: String) -> String? {
        let components = value.hasPrefix("v") ? value.dropFirst() : value[...]
        let releaseComponents = components.split(
            separator: "-",
            maxSplits: 1,
            omittingEmptySubsequences: false,
        )
        let fields = releaseComponents[0].split(
            separator: ".",
            omittingEmptySubsequences: false,
        )
        guard fields.count == 3, fields.allSatisfy(isNumericIdentifier)
        else {
            return nil
        }
        if releaseComponents.count == 2 {
            let identifiers = releaseComponents[1].split(
                separator: ".",
                omittingEmptySubsequences: false,
            )
            guard identifiers.allSatisfy(isPrereleaseIdentifier) else {
                return nil
            }
        }
        return String(components)
    }

    private static nonisolated func isNumericIdentifier(_ value: Substring) -> Bool {
        !value.isEmpty && value.allSatisfy({ $0.isASCII && $0.isNumber })
    }

    private static nonisolated func isPrereleaseIdentifier(_ value: Substring) -> Bool {
        !value.isEmpty
            && value.allSatisfy({ character in
                character.isASCII
                    && (character.isLetter || character.isNumber || character == "-")
            })
    }
}
