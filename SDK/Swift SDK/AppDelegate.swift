//
//  AppDelegate.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

enum LanguageIndex: Int {
    case english = 0
    case japanese
    case french
    case portuguese
    case spanish
    case german
    case russian
    case simplifiedChinese
    case traditionalChinese
    case cjkUnifiedIdeograph
}

enum PaperSizeIndex: Int {
    case twoInch = 384
    case threeInch = 576
    case fourInch = 832
    case escPosThreeInch = 512
    case dotImpactThreeInch = 210
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let settingManager = SettingManager()
    
    static func isSystemVersionEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
    }
    
    static func isSystemVersionGreaterThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
    }
    
    static func isSystemVersionGreaterThanOrEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
    }
    
    static func isSystemVersionLessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
    }
    
    static func isSystemVersionLessThanOrEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
    }
    
    static func isIPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    static func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    var window: UIWindow?
    
    var portName:     String!
    var portSettings: String!
    var modelName:    String!
    var macAddress:   String!
    
    var emulation:                StarIoExtEmulation!
    var cashDrawerOpenActiveHigh: Bool!
    var allReceiptsSettings:      Int!
    var selectedIndex:            Int!
    var selectedLanguage:         LanguageIndex!
    var selectedPaperSize:        Int?
    var selectedModelIndex:       Int?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 1.0)     // 1000mS!!!
        
        self.loadParam()
        
        self.selectedIndex     = 0
        self.selectedLanguage  = LanguageIndex.english
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    fileprivate func loadParam() {
        AppDelegate.settingManager.load()
    }
    
    static func getPortName() -> String {
        return settingManager.settings[0]?.portName ?? ""
    }
    
    static func setPortName(_ portName: String) {
        settingManager.settings[0]?.portName = portName
        settingManager.save()
    }
    
    static func getPortSettings() -> String {
        return settingManager.settings[0]?.portSettings ?? ""
    }
    
    static func setPortSettings(_ portSettings: String) {
        settingManager.settings[0]?.portSettings = portSettings
        settingManager.save()
    }
    
    static func getModelName() -> String {
        return settingManager.settings[0]?.modelName ?? ""
    }
    
    static func setModelName(_ modelName: String) {
        settingManager.settings[0]?.modelName = modelName
        settingManager.save()
    }
    
    static func getMacAddress() -> String {
        return settingManager.settings[0]?.macAddress ?? ""
    }
    
    static func setMacAddress(_ macAddress: String) {
        settingManager.settings[0]?.macAddress = macAddress
        settingManager.save()
    }
    
    static func getEmulation() -> StarIoExtEmulation {
        return settingManager.settings[0]?.emulation ?? .starPRNT
    }
    
    static func setEmulation(_ emulation: StarIoExtEmulation) {
        settingManager.settings[0]?.emulation = emulation
        settingManager.save()
    }
    
    static func getCashDrawerOpenActiveHigh() -> Bool {
        return settingManager.settings[0]?.cashDrawerOpenActiveHigh ?? true
    }
    
    static func setCashDrawerOpenActiveHigh(_ activeHigh: Bool) {
        settingManager.settings[0]?.cashDrawerOpenActiveHigh = activeHigh
        settingManager.save()
    }
    
    static func getAllReceiptsSettings() -> Int {
        return settingManager.settings[0]?.allReceiptsSettings ?? 0x07
    }
    
    static func setAllReceiptsSettings(_ allReceiptsSettings: Int) {
        settingManager.settings[0]?.allReceiptsSettings = allReceiptsSettings
        settingManager.save()
    }
    
    static func getSelectedIndex() -> Int {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.selectedIndex!
    }
    
    static func setSelectedIndex(_ index: Int) {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.selectedIndex = index
    }
    
    static func getSelectedLanguage() -> LanguageIndex {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.selectedLanguage!
    }
    
    static func setSelectedLanguage(_ index: LanguageIndex) {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.selectedLanguage = index
    }
    
    static func getSelectedPaperSize() -> PaperSizeIndex {
        return AppDelegate.settingManager.settings[0]?.selectedPaperSize ?? .threeInch
    }
    
    static func setSelectedPaperSize(_ index: PaperSizeIndex) {
        AppDelegate.settingManager.settings[0]?.selectedPaperSize = index
        settingManager.save()
    }
    
    static func getSelectedModelIndex() -> ModelIndex? {
        return AppDelegate.settingManager.settings[0]?.selectedModelIndex
    }
    
    static func setSelectedModelIndex(_ modelIndex: ModelIndex?) {
        settingManager.settings[0]?.selectedModelIndex = modelIndex ?? .none
        settingManager.save()
    }
}
