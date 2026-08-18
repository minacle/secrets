import Testing

@testable
import Secrets

@Suite("Versions")
struct VersionsTests {

    @Test
    func `stable and prerelease tags report their release versions`() {
        #expect(Versions.current(tag: "v2.0.0", commit: "abcdef123456") == "2.0.0")
        #expect(
            Versions.current(tag: "v2.0.0-rc.1", commit: "abcdef123456")
                == "2.0.0-rc.1",
        )
    }

    @Test
    func `nonrelease tags report development versions from the commit`() {
        for tag in ["next", "v2.0", "v2.0.0-", "v2.0.0-rc..1"] {
            #expect(Versions.current(tag: tag, commit: "abcdef123456") == "dev+abcdef1")
        }
        #expect(Versions.current(tag: "", commit: "") == "dev")
    }
}
