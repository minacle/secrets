import os

enum SecretsError: Equatable, Error {
    case duplicateItem
    case itemNotFound
    case unexpectedItemType
    case unhandledStatus(OSStatus)
}
