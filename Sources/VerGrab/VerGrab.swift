// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
#if !os(macOS)
import UIKit
#endif


final public class VerGrab:Sendable {
    @MainActor public static let shared = VerGrab()
    
    private init() {}
    
    public func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    public func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    public func machineName() -> String {
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
    
    @MainActor public func osVersion() -> String {
#if os(macOS)
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return "\(os.majorVersion).\(os.minorVersion).\(os.patchVersion)"
#else
        return UIDevice.current.systemVersion
#endif
    }
    
    public func appInfo() -> String {
        return "\(appVersion())(\(appBuild()))"
    }
    
    @MainActor public func description() -> String {
        return "\(appVersion())(\(appBuild()))/\(machineName())/\(osVersion())"
    }
    
}
