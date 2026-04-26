

# VerGrab

軽量なユーティリティライブラリ。アプリや実行環境のバージョン／ビルド情報、マシン識別子、実行環境（TestFlight / App Store / Simulator / Mac Catalyst / Debug）の判定を提供します。

## インストール
Swift Package Manager を使って導入します。Package.swift に依存として追加してください。

```swift
.package(url: "https://github.com/yourname/VerGrab.git", from: "0.1.0"),
```

## 使い方
インポートしてシングルトンからプロパティにアクセスします。

```swift
import VerGrab

let v = VerGrab.shared
print(v.appVersion)                // CFBundleShortVersionString
print(v.appBuild)                  // CFBundleVersion
print(v.appVersionAndBuild)        // "1.2.3(45)" 形式
print(v.machineIdentifier)         // hw.machine / hw.model
print(v.operatingSystemName)       // OSの名前
print(v.operatingSystemVersion)    // OS バージョン文字列
print(v.isInstalledViaAppStore)    // App Store 経由か
print(v.isInstalledViaTestFlight)  // TestFlight か
print(v.isRunningOnSimulator)      // シミュレータ上か
print(v.isRunningOnMacCatalyst)    // Mac Catalyst 上か
print(v.isDebugConfiguration)      // Debug ビルドか
print(v.isAppleIntelligenceAvailable) // Apple Intelligence 利用可否
print(v.detailedDescription)       // 詳細な一行文字列
```

## テスト
ローカルでテストを実行するには:

```bash
swift test
```

## ライセンス
このリポジトリは [LICENSE](LICENSE) の下でライセンスされています。
