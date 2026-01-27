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
    
    // アプリのバージョン文字列
    public var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    // アプリのビルド番号
    public var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    // マシン識別子
    public var machineIdentifier: String {
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
    
    // OSのバージョン文字列
    @MainActor public var operatingSystemVersion: String {
#if os(macOS)
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return "\(os.majorVersion).\(os.minorVersion).\(os.patchVersion)"
#else
        return UIDevice.current.systemVersion
#endif
    }
    
    // アプリのバージョンとビルド番号
    public var appVersionAndBuild: String {
        return "\(appVersion)(\(appBuild))"
    }
    
    // TestFlight経由でインストールしたアプリのときtrueを返す
    public var isInstalledViaTestFlight: Bool {
#if DEBUG
        return false
#else
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL else {
            return false
        }
        
        return appStoreReceiptURL.path.contains("sandboxReceipt")
#endif
    }

    // App Store経由でインストールしたアプリのときtrueを返す
    // 受け取れるレシートが存在し、かつサンドボックスレシートでない場合をApp Storeインストールと判断する
    public var isInstalledViaAppStore: Bool {
#if DEBUG
        return false
#else
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL else {
            return false
        }

        // サンドボックスでない receipt が存在すれば App Store 経由での配布と判断
        return !appStoreReceiptURL.path.contains("sandboxReceipt")
#endif
    }
    
    // シミュレータ上で動作しているときtrueを返す
    public var isRunningOnSimulator: Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    // Mac Catalyst上で動作しているときtrueを返す
    public var isRunningOnMacCatalyst: Bool {
#if targetEnvironment(macCatalyst)
        return true
#else
        return false
#endif
    }
    
    // デバッグビルドのときtrueを返す
    public var isDebugConfiguration: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
    
    // Apple Intelligenceが利用可能なときtrueを返す
    public var isAppleIntelligenceAvailable: Bool {
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
    
    // 詳細なアプリのバージョン情報を取得する
    @MainActor public var detailedDescription: String {
        let subPart = [
            isInstalledViaTestFlight ? ";TestFlight" : "",
            isRunningOnSimulator ? ";Simulator" : "",
            isRunningOnMacCatalyst ? ";MacCatalyst" : "",
            isDebugConfiguration ? ";Debug" : ""
        ].joined(separator: "")
        
        return "\(appVersion)(\(appBuild)\(subPart))/\(machineIdentifier)/\(operatingSystemVersion)"
    }
    
    // App StoreのURLを取得する
    // appleId: App StoreでのアプリのID
    // withWriteReview: レビュー投稿画面を開く場合はtrue
    public func appSotreUrl(appleId: Int, withWriteReview: Bool) -> URL? {
        let urlString = "https://apps.apple.com/app/id\(appleId)" + (withWriteReview ? "?action=write-review" : "")
        return URL(string: urlString)
    }
}
