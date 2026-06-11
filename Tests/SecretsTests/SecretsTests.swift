import Testing

@testable
import Secrets

@Suite(.serialized)
struct SecretsTests {

    @Test
    func `delete non-existing secret`() {
        #expect(throws: SecretsError.itemNotFound) {
            try delete(key: "NON_EXISTING_KEY")
        }
    }

    @Test
    func `read non-existing secret`() {
        #expect(throws: SecretsError.itemNotFound) {
            try read(key: "NON_EXISTING_KEY")
        }
    }

    @Test
    func `rename non-existing secret`() {
        #expect(throws: SecretsError.itemNotFound) {
            try rename(oldKey: "NON_EXISTING_KEY", newKey: "ANY_KEY")
        }
    }

    @Test
    func `write, read, rename a secret`() throws {
        let key = "SECRETS_TEST_KEY_ALPHA"
        let value = "SECRETS_TEST_VALUE"
        try write(key: key, value: value)
        #expect(try read(key: key) == value)

        let newKey = "SECRETS_TEST_KEY_OMEGA"
        try rename(oldKey: key, newKey: newKey)
        #expect(try read(key: newKey) == value)
    }

    @Test
    func `write a secret with existing key`() throws {
        let key = "SECRETS_TEST_KEY_ALPHA"
        let value1 = "SECRETS_TEST_OLD_VALUE"
        try write(key: key, value: value1)
        #expect(try read(key: key) == value1)

        let value2 = "SECRETS_TEST_NEW_VALUE"
        try write(key: key, value: value2)
        #expect(try read(key: key) == value2)
    }

    @Test
    func `rename a secret to an existing key`() {
        let key1 = "SECRETS_TEST_KEY_ALPHA"
        let key2 = "SECRETS_TEST_KEY_OMEGA"
        #expect(throws: SecretsError.duplicateItem) {
            try rename(oldKey: key1, newKey: key2)
        }
    }

    @Test
    func `delete secrets and verify`() throws {
        let key1 = "SECRETS_TEST_KEY_ALPHA"
        let key2 = "SECRETS_TEST_KEY_OMEGA"
        try delete(key: key1)
        try delete(key: key2)
        #expect(throws: SecretsError.itemNotFound) {
            try read(key: key1)
        }
        #expect(throws: SecretsError.itemNotFound) {
            try read(key: key2)
        }
    }
}
