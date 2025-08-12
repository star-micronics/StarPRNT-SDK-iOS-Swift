// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StarPRNTSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "StarPRNTSDK",
            targets: ["StarPRNTSDK"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "StarPRNTSDK",
            dependencies: [
                "StarIO",
                "StarIO_Extension"
            ],
            path: "SDK/Swift SDK",
            exclude: [
                "Info.plist",
                "Swift SDK.entitlements",
                "PrivacyInfo.xcprivacy",
                "Assets.xcassets",
                "LaunchScreen.storyboard",
                "Main.storyboard",
                "AppDelegate.swift",
                "Base.lproj"
            ],
            sources: [
                "Communications/Communication.swift",
                "Communications/CommunicationResult.swift",
                "Functions/PrinterFunctions.swift",
                "Functions/CashDrawerFunctions.swift",
                "Functions/DisplayFunctions.swift",
                "Functions/MelodySpeakerFunctions.swift",
                "Functions/CombinationFunctions.swift",
                "Functions/ApiFunctions.swift",
                "SMDefine.swift",
                "ModelCapability.swift",
                "GlobalQueueManager.swift",
                "SettingManager.swift",
                "LocalizeReceipts/ILocalizeReceipts.swift",
                "LocalizeReceipts/EnglishReceiptsImpl.swift",
                "LocalizeReceipts/JapaneseReceiptsImpl.swift",
                "LocalizeReceipts/FrenchReceiptsImpl.swift",
                "LocalizeReceipts/PortugueseReceiptsImpl.swift",
                "LocalizeReceipts/SpanishReceiptsImpl.swift",
                "LocalizeReceipts/GermanReceiptsImpl.swift",
                "LocalizeReceipts/RussianReceiptsImpl.swift",
                "LocalizeReceipts/SimplifiedChineseReceiptsImpl.swift",
                "LocalizeReceipts/TraditionalChineseReceiptsImpl.swift",
                "LocalizeReceipts/Utf8MultiLanguageReceiptsImpl.swift"
            ]
        ),
        .binaryTarget(
            name: "StarIO",
            path: "SDK/Pods/StarIO/StarIO.xcframework"
        ),
        .binaryTarget(
            name: "StarIO_Extension",
            path: "SDK/Pods/StarIO_Extension/StarIO_Extension.xcframework"
        )
    ]
)