# VerGrab

A lightweight utility library to retrieve app and runtime environment information such as app version/build, machine identifier, and environment flags (TestFlight / App Store / Simulator / Mac Catalyst / Debug).

## Installation

Add the package using the Swift Package Manager. In your `Package.swift` add the dependency:

```swift
.package(url: "https://github.com/yourname/VerGrab.git", from: "0.1.0"),
```

## Usage

Import the package and access the shared singleton's computed properties:

```swift
import VerGrab

let v = VerGrab.shared
print(v.appVersion)                // CFBundleShortVersionString
print(v.appBuild)                  // CFBundleVersion
print(v.appVersionAndBuild)        // e.g. "1.2.3(45)"
print(v.machineIdentifier)         // hw.machine / hw.model
print(v.operatingSystemName)       // OS name
print(v.operatingSystemVersion)    // OS version string
print(v.isInstalledViaAppStore)    // true if installed from App Store
print(v.isInstalledViaTestFlight)  // true if installed via TestFlight
print(v.isRunningOnSimulator)      // true if running in simulator
print(v.isRunningOnMacCatalyst)    // true if running on Mac Catalyst
print(v.isDebugConfiguration)      // true for Debug builds
print(v.isAppleIntelligenceAvailable) // Apple Intelligence availability
print(v.detailedDescription)       // single-line detailed string
```

## Tests

Run tests locally with:

```bash
swift test
```

## License

This repository is licensed under the terms in [LICENSE](LICENSE).
