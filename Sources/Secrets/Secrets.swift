import ArgumentParser
import Foundation
import Security

private nonisolated let service = "moe.minacle.secrets"

nonisolated func delete(key: String) throws(SecretsError) {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: key,
    ] as CFDictionary
    let status = SecItemDelete(query)
    guard status == errSecSuccess
    else {
        if status == errSecItemNotFound {
            throw .itemNotFound
        }
        throw .unhandledStatus(status)
    }
}

nonisolated func read(key: String) throws(SecretsError) -> String {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: key,
        kSecReturnData: true,
    ] as CFDictionary
    var item: CFTypeRef?
    let status = unsafe SecItemCopyMatching(query, &item)
    guard status == errSecSuccess
    else {
        if status == errSecItemNotFound {
            throw .itemNotFound
        } else {
            throw .unhandledStatus(status)
        }
    }
    guard
        let data = item as? Data,
        let value = String(data: data, encoding: .utf8)
    else {
        throw .unexpectedItemType
    }
    return value
}

nonisolated func rename(oldKey: String, newKey: String) throws(SecretsError) {
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: oldKey,
    ] as CFDictionary
    let attributesToUpdate = [
        kSecAttrAccount: newKey,
    ] as CFDictionary
    let status = SecItemUpdate(query, attributesToUpdate)
    guard status == errSecSuccess
    else {
        if status == errSecItemNotFound {
            throw .itemNotFound
        }
        if status == errSecDuplicateItem {
            throw .duplicateItem
        }
        throw .unhandledStatus(status)
    }
}

nonisolated func write(key: String, value: String) throws(SecretsError) {
    let valueData = value.data(using: .utf8)!
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: key,
        kSecValueData: valueData,
    ] as CFDictionary
    var status = SecItemAdd(query, nil)
    if status == errSecDuplicateItem {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
        ] as CFDictionary
        let attributesToUpdate = [
            kSecValueData: valueData,
        ] as CFDictionary
        status = SecItemUpdate(query, attributesToUpdate)
    }
    guard status == errSecSuccess
    else {
        throw .unhandledStatus(status)
    }
}
