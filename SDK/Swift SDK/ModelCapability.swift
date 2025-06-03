//
//  ModelCapability.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

enum ModelIndex: Int {     // Don't insert(Only addition)
    case none = 0
    case mCPrint2
    case mCPrint3
    case mCLabel2
    case mCLabel3
    case mpop
    case fvp10
    case tsp100
    case tsp100IV
    case tsp650II
    case tsp700II
    case tsp800II
    case sm_S210I
    case sm_S220I
    case sm_S230I
    case sm_T300I
    case sm_T400I
    case bsc10
    case bsc10ii
    case sm_S210I_StarPRNT
    case sm_S220I_StarPRNT
    case sm_S230I_StarPRNT
    case sm_T300I_StarPRNT
    case sm_T400I_StarPRNT
    case sm_L200
    case sp700
    case sm_L300
}

class PrinterInfo {
    let title: String
    
    let emulation: StarIoExtEmulation
    
    let supportedExternalCashDrawer: Bool
    
    let portSettings: String
    
    let modelNameArray: [String]
    
    let textReceiptIsEnabled: Bool
    
    let UTF8IsEnabled: Bool
    
    let rasterReceiptIsEnabled: Bool
    
    let CJKIsEnabled: Bool
    
    let blackMarkIsEnabled: Bool
    
    let blackMarkDetectionIsEnabled: Bool
    
    let pageModeIsEnabled: Bool
    
    let paperPresentStatusIsEnabled: Bool
    
    let autoSwitchInterfaceIsEnabled: Bool
    
    let cashDrawerIsEnabled: Bool
    
    let barcodeReaderIsEnabled: Bool
    
    let customerDisplayIsEnabled: Bool
    
    let melodySpeakerIsEnabled: Bool
    
    let productSerialNumberIsEnabled: Bool
    
    let supportBluetoothDisconnection: Bool
    
    init(_ title: String,
         _ emulation: StarIoExtEmulation,
         _ supportedExternalCashDrawer: Bool,
         _ portSettings: String,
         _ modelNameArray: [String],
         _ textReceiptIsEnabled: Bool,
         _ UTF8IsEnabled: Bool,
         _ rasterReceiptIsEnabled: Bool,
         _ CJKIsEnabled: Bool,
         _ blackMarkIsEnabled: Bool,
         _ blackMarkDetectionIsEnabled: Bool,
         _ pageModeIsEnabled: Bool,
         _ paperPresentStatusIsEnabled: Bool,
         _ autoSwitchInterfaceIsEnabled: Bool,
         _ cashDrawerIsEnabled: Bool,
         _ barcodeReaderIsEnabled: Bool,
         _ customerDisplayIsEnabled: Bool,
         _ melodySpeakerIsEnabled: Bool,
         _ productSerialNumberIsEnabled: Bool,
         _ supportBluetoothDisconnection: Bool
        ) {
        self.title = title
        self.emulation = emulation
        self.supportedExternalCashDrawer = supportedExternalCashDrawer
        self.portSettings = portSettings
        self.modelNameArray = modelNameArray
        
        self.textReceiptIsEnabled = textReceiptIsEnabled
        self.UTF8IsEnabled = UTF8IsEnabled
        self.rasterReceiptIsEnabled = rasterReceiptIsEnabled
        self.CJKIsEnabled = CJKIsEnabled
        self.blackMarkIsEnabled = blackMarkIsEnabled
        self.blackMarkDetectionIsEnabled = blackMarkDetectionIsEnabled
        self.pageModeIsEnabled = pageModeIsEnabled
        self.paperPresentStatusIsEnabled = paperPresentStatusIsEnabled
        self.autoSwitchInterfaceIsEnabled = autoSwitchInterfaceIsEnabled
        self.cashDrawerIsEnabled = cashDrawerIsEnabled
        self.barcodeReaderIsEnabled = barcodeReaderIsEnabled
        self.customerDisplayIsEnabled = customerDisplayIsEnabled
        self.melodySpeakerIsEnabled = melodySpeakerIsEnabled
        self.productSerialNumberIsEnabled = productSerialNumberIsEnabled
        self.supportBluetoothDisconnection = supportBluetoothDisconnection
    }
}

class ModelCapability : NSObject {
    enum ModelCapabilityIndex: Int {
        case title = 0
        case emulation
        case cashDrawerOpenActive
        case portSettings
        case modelNameArray
    }
    
    static let modelIndexArray: [ModelIndex] = [
        ModelIndex.mCPrint2,
        ModelIndex.mCPrint3,
        ModelIndex.mCLabel2,
        ModelIndex.mCLabel3,
        ModelIndex.mpop,
        ModelIndex.fvp10,
        ModelIndex.tsp100,
        ModelIndex.tsp100IV,
        ModelIndex.tsp650II,
        ModelIndex.tsp700II,
        ModelIndex.tsp800II,
        ModelIndex.sp700,
        ModelIndex.sm_S210I,
        ModelIndex.sm_S220I,
        ModelIndex.sm_S230I,
        ModelIndex.sm_T300I,
        ModelIndex.sm_T400I,
        ModelIndex.sm_L200,
        ModelIndex.sm_L300,
        ModelIndex.bsc10,
        ModelIndex.bsc10ii,
        ModelIndex.sm_S210I_StarPRNT,
        ModelIndex.sm_S220I_StarPRNT,
        ModelIndex.sm_S230I_StarPRNT,
        ModelIndex.sm_T300I_StarPRNT,
        ModelIndex.sm_T400I_StarPRNT
    ]
    
    @MainActor
    static let modelCapabilityDictionary: [ModelIndex: PrinterInfo] = [
        .mCPrint2: PrinterInfo("mC-Print2", .starPRNT, true, "", ["MCP20 (STR-001)", "MCP21 (STR-001)", "MCP21"],
                               true, true, true, true, false, false, true, false, true,
                               true, true, true, false, true, false),
        .mCPrint3: PrinterInfo("mC-Print3", .starPRNT, true, "", ["MCP30 (STR-001)", "MCP31"],
                               true, true, true, true, false, false, true, false, true,
                               true, true, true, true, true, false),
        .mCLabel2: PrinterInfo("mC-Label2", .starPRNT, false, "", ["MCL21 (STR-001)", "MCL21"],
                               true, true, true, true, true, true, true, true, true,
                               false, true, true, false, true, false),
        .mCLabel3: PrinterInfo("mC-Label3", .starPRNT, true, "", ["MCL32 (STR-001)", "MCL32"],
                               true, true, true, true, true, true, true, true, true,
                               true, true, true, false, true, false),
        .mpop:     PrinterInfo("mPOP", .starPRNT, false, "", ["POP10"],
                               true, true, true, false, false, false, true, false, false,
                               true, true, true, false, true, true),
        .fvp10:    PrinterInfo("FVP10", .starLine, true, "", ["FVP10 (STR_T-001)"],
                               true, true, true, false, true, true, true, false, false,
                               true, false, false, true, false, true),    // Only LAN model
        .tsp100:   PrinterInfo("TSP100", .starGraphic, true, "", ["TSP113", "TSP143"],
                               false, false, true, false, false, false, false, false, false,
                               true, false, false, false, true, false),
        .tsp100IV: PrinterInfo("TSP100IV", .starPRNT, true, "", ["TSP143IV (STR-001)", "TSP143IV-UEWB", "TSP143IV-UEWB SK"],
                               true, true, true, true, false, false, true, true, false,
                               true, true, true, true, true, false),
        .tsp650II: PrinterInfo("TSP650II", .starLine, true, "", ["TSP654II (STR_T-001)",
                                                                 // Only LAN model->
                                                                 "TSP654 (STR_T-001)", "TSP651 (STR_T-001)"],
                               true, true, true, true, false, false, true, true, false,
                               true, false, false, false, false, true),
        .tsp700II: PrinterInfo("TSP700II", .starLine, true, "", ["TSP743II (STR_T-001)", "TSP743 (STR_T-001)"],
                               true, true, true, false, true, true, true, false, false,
                               true, false, false, false, false, true),
        .tsp800II: PrinterInfo("TSP800II", .starLine, true, "", ["TSP847II (STR_T-001)", "TSP847 (STR_T-001)"],
                               true, true, true, false, true, true, false, false, false,
                               true, false, false, false, false, true),
        // <-Only LAN model
        // Sample->
        .sm_S210I: PrinterInfo("SM-S210i", .escPosMobile, false, "mini", ["SM-S210i"],
                               true, false, true, false, false, false, true, false, false,
                               false, false, false, false, false, false),
        .sm_S220I: PrinterInfo("SM-S220i", .escPosMobile, false, "mini", ["SM-S220i"],
                               true, false, true, false, false, false, true, false, false,
                               false, false, false, false, false, false),
        .sm_S230I: PrinterInfo("SM-S230i", .escPosMobile, false, "mini", ["SM-S230i"],
                               true, false, true, false, false, false, true, false, false,
                               false, false, false, false, false, false),
        .sm_T300I: PrinterInfo("SM-T300i/T300", .escPosMobile, false, "mini", ["SM-T300i"],
                               true, false, true, false, true, false, true, false, false,
                               false, false, false, false, false, false),
        .sm_T400I: PrinterInfo("SM-T400i", .escPosMobile, false, "mini", ["SM-T400i"],
                               true, false, true, false, true, false, true, false, false,
                               false, false, false, false, false, false),
        // <-Sample
        .bsc10:    PrinterInfo("BSC10", .escPos, true, "escpos", ["BSC10"],
                               true, false, true, false, false, false, true, false, false,
                               true, false, false, false, false, false),
        .bsc10ii:  PrinterInfo("BSC10II", .starPRNT, true, "", ["BSC10II (STR-001)"],
                               true, true, true, true, false, false, true, false, false,
                               true, false, false, false, true, false),
        .sm_S210I_StarPRNT: PrinterInfo("SM-S210i StarPRNT", .starPRNT, false, "Portable", ["SM-S210i StarPRNT"],
                                        true, false, true, false, false, false, true, false, false,
                                        false, false, false, false, false, false),
        // Sample->
        .sm_S220I_StarPRNT: PrinterInfo("SM-S220i StarPRNT", .starPRNT, false, "Portable", ["SM-S220i StarPRNT"],
                                        true, false, true, false, false, false, true, false, false,
                                        false, false, false, false, false, false),
        .sm_S230I_StarPRNT: PrinterInfo("SM-S230i StarPRNT", .starPRNT, false, "Portable", ["SM-S230i StarPRNT"],
                                        true, false, true, false, false, false, true, false, false,
                                        false, false, false, false, false, false),
        .sm_T300I_StarPRNT: PrinterInfo("SM-T300i/T300 StarPRNT", .starPRNT, false, "Portable", ["SM-T300i StarPRNT"],
                                        true, false, true, false, true, true, true, false, false,
                                        false, false, false, false, false, false),
        .sm_T400I_StarPRNT: PrinterInfo("SM-T400i StarPRNT", .starPRNT, false, "Portable", ["SM-T400i StarPRNT"],
                                        true, false, true, false, true, true, true, false, false,
                                        false, false, false, false, false, false),
        // <-Sample
        .sm_L200: PrinterInfo("SM-L200", .starPRNT, false, "Portable", ["SM-L200"],
                              true, false, true, false, true, true, true, false, false,
                              false, false, false, false, false, false),
        .sp700: PrinterInfo("SP700", .starDotImpact, true, "", ["SP712 (STR-001)",
                                         // Only LAN model
                            "SP717 (STR-001)", "SP742 (STR-001)", "SP747 (STR-001)"],
                            true, true, false, false, true, true, false, false, false,
                            true, false, false, false, false, true),
        .sm_L300: PrinterInfo("SM-L300", .starPRNTL, false, "Portable", ["SM-L300"],
                              true, false, true, false, true, false, true, false, false,
                              false, false, false, false, false, false)
    ]
    
    static func modelIndexCount() -> Int {
        return ModelCapability.modelIndexArray.count
    }
    
    static func modelIndex(at index: Int) -> ModelIndex {
        return ModelCapability.modelIndexArray[index]
    }
    
    @MainActor
    static func title(at modelIndex: ModelIndex) -> String? {
        return ModelCapability.modelCapabilityDictionary[modelIndex]?.title
    }
    
    @MainActor
    static func emulation(at modelIndex: ModelIndex) -> StarIoExtEmulation? {
        return ModelCapability.modelCapabilityDictionary[modelIndex]?.emulation
    }
    
    @MainActor
    static func supportedExternalCashDrawer(at modelIndex: ModelIndex) -> Bool? {
        return ModelCapability.modelCapabilityDictionary[modelIndex]?.supportedExternalCashDrawer
    }
    
    @MainActor
    static func portSettings(at modelIndex: ModelIndex) -> String? {
        return ModelCapability.modelCapabilityDictionary[modelIndex]?.portSettings
    }
    
    @MainActor
    static func modelIndex(of modelName: String) -> ModelIndex? {
        for (modelIndex, printerInfo) in ModelCapability.modelCapabilityDictionary {
            for i: Int in 0 ..< printerInfo.modelNameArray.count {
                if modelName == printerInfo.modelNameArray[i] {
                    return modelIndex
                }
            }
        }
        
        for (modelIndex, printerInfo) in ModelCapability.modelCapabilityDictionary {
            for i: Int in 0 ..< printerInfo.modelNameArray.count {
                if modelName.hasPrefix(printerInfo.modelNameArray[i]) == true {
                    return modelIndex
                }
            }
        }
        
        return nil
    }
}
