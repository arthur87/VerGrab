import Testing
@testable import VerGrab

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    print(VerGrab.shared.appVersion())
    print(VerGrab.shared.appBundleVersion())
    print(VerGrab.shared.machineName())
    await print(VerGrab.shared.osVersion())
    await print(VerGrab.shared.description())
}
