// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
#if !os(macOS)
import UIKit
#endif


final public class VerGrab {
    nonisolated(unsafe) static let shared = VerGrab()
    
    private init() {}
    
    func appVersion() -> String {
        var version = ""
        if let value = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            version = value
        }
        return version
    }
    
    func appBundleVersion() -> String {
        var version = ""
        if let value = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            version = value
        }
        return version
    }
    
    func machineName() -> String {
#if os(macOS)
        let name = "hw.model"
#else
        let name = "hw.machine"
#endif
        
        var size: Int = 0
        sysctlbyname(name, nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname(name, &machine, &size, nil, 0)
        let data = Data(bytes: machine, count: size - 1)
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    @MainActor func osVersion() -> String {
#if os(macOS)
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return "\(os.majorVersion).\(os.minorVersion).\(os.patchVersion)"
#else
        return UIDevice.current.systemVersion
#endif
    }
    
    @MainActor func description() -> String {
        return "\(appVersion())(\(appBundleVersion()))/\(machineName())/\(osVersion())"
    }
    
}
