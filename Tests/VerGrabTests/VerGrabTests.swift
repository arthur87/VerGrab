import Testing
@testable import VerGrab

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    await print(VerGrab.shared.appVersion())
    await print(VerGrab.shared.appBuild())
    await print(VerGrab.shared.machineName())
    await print(VerGrab.shared.osVersion())
    await print(VerGrab.shared.appInfo())
    await print(VerGrab.shared.description())
    await print(VerGrab.shared.isTestFlight())
    await print(VerGrab.shared.isAppleIntelligenceAvailable())
}
