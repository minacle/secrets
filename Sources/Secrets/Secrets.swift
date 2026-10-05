import Foundation
import KeychainKit

private let keychain = Keychain(storage: .fileBased())

private let service = "moe.minacle.secrets"

func delete(key: String) throws(KeychainError) {
    try keychain.delete(matching: firstItemQuery(key: key))
}

func read(key: String) throws(KeychainError) -> String {
    guard let item = try keychain.fetchFirst(matching: Query(service: service, account: key))
    else {
        throw KeychainError(code: .itemNotFound)
    }
    guard let value = item.password
    else {
        throw KeychainError(code: .decodingFailed)
    }
    return value
}

func rename(oldKey: String, newKey: String) throws(KeychainError) {
    var changes = Item<GenericPassword>()
    changes.account = newKey
    try keychain.update(matching: firstItemQuery(key: oldKey), with: changes)
}

func write(key: String, value: String) throws(KeychainError) {
    do {
        try keychain.add(Item(service: service, account: key, password: value))
    } catch where error.code == .duplicateItem {
        var changes = Item<GenericPassword>()
        changes.password = value
        try keychain.update(matching: firstItemQuery(key: key), with: changes)
    }
}

private func firstItemQuery(key: String) throws(KeychainError) -> Query<GenericPassword> {
    guard let reference = try keychain.fetchFirstPersistentReference(matching: Query(service: service, account: key))
    else {
        throw KeychainError(code: .itemNotFound)
    }
    var query = Query<GenericPassword>()
    query.persistentReference = reference
    return query
}
