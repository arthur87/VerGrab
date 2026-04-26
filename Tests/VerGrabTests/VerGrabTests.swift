import Testing
@testable import VerGrab

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    await print(VerGrab.shared.appVersion)
    await print(VerGrab.shared.appBuild)
    await print(VerGrab.shared.machineIdentifier)
    await print(VerGrab.shared.operatingSystemName)
    await print(VerGrab.shared.operatingSystemVersion)
    await print(VerGrab.shared.appVersionAndBuild)
    await print(VerGrab.shared.detailedDescription)
    await print(VerGrab.shared.isInstalledViaTestFlight)
    await print(VerGrab.shared.isInstalledViaAppStore)
    await print(VerGrab.shared.isAppleIntelligenceAvailable)
    await print(VerGrab.shared.appSotreUrl(appleId: 1234567890, withWriteReview: true))
}
