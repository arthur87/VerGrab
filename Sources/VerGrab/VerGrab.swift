// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
#if !os(macOS)
import UIKit
#endif
#if !(os(tvOS) || os(watchOS))
import FoundationModels
#endif

final public class VerGrab:Sendable {
    @MainActor public static let shared = VerGrab()
    
    private init() {}
    
    // アプリのバージョンを返す
    public func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    // アプリのビルド番号を返す
    public func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    // マシンネームを返す
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
    
    // OSのバージョンを返す
    @MainActor public func osVersion() -> String {
#if os(macOS)
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return "\(os.majorVersion).\(os.minorVersion).\(os.patchVersion)"
#else
        return UIDevice.current.systemVersion
#endif
    }
    
    // アプリのバージョンとビルド番号を返す
    public func appInfo() -> String {
        return "\(appVersion())(\(appBuild()))"
    }
    
    // TestFlight経由でインストールしたアプリのときtrueを返す
    public func isTestFlight() -> Bool {
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL else {
            return false
        }
        
        return appStoreReceiptURL.path.contains("sandboxReceipt")
    }
    
    // シミュレータ上で動作しているときtrueを返す
    public func isSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    // Mac Catalyst上で動作しているときtrueを返す
    public func isMacCatalyst() -> Bool {
#if targetEnvironment(macCatalyst)
        return true
#else
        return false
#endif
    }
    
    // デバッグビルドのときtrueを返す
    public func isDebugBuild() -> Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
    
    // Apple Intelligenceが利用可能なときtrueを返す
    public func isAppleIntelligenceAvailable() -> Bool {
#if os(tvOS) || os(watchOS)
        return false
#else
        if #available(macOS 26.0, iOS 26.0, visionOS 26.0, *) {
            return SystemLanguageModel.default.isAvailable
        } else {
            return false
        }
#endif
    }
    
    @MainActor public func description() -> String {
        let subPart = [
            isTestFlight() ? ";TestFlight" : "",
            isSimulator() ? ";Simulator" : "",
            isMacCatalyst() ? ";MacCatalyst" : "",
            isDebugBuild() ? ";Debug" : ""
        ].joined(separator: "")
        
        return "\(appVersion())(\(appBuild())\(subPart))/\(machineName())/\(osVersion())"
    }
    
}
