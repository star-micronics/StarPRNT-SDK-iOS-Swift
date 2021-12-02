//
//  SettingManager.swift
//  Swift SDK
//
//  Created by u3237 on 2018/06/04.
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

import Foundation

class PrinterSetting: NSObject, NSCoding {
    var portName: String
    
    var portSettings: String
    
    var modelName: String
    
    var macAddress: String
    
    var emulation: StarIoExtEmulation
    
    var cashDrawerOpenActiveHigh: Bool
    
    var selectedPaperSize: PaperSizeIndex
    
    var selectedModelIndex: ModelIndex

    
    init(portName: String, portSettings: String, macAddress: String, modelName: String,
         emulation: StarIoExtEmulation, cashDrawerOpenActiveHigh: Bool,
         selectedPaperSize: PaperSizeIndex, selectedModelIndex: ModelIndex) {
        self.portName = portName
        self.portSettings = portSettings
        self.macAddress = macAddress
        self.modelName = modelName
        self.emulation = emulation
        self.cashDrawerOpenActiveHigh = cashDrawerOpenActiveHigh
        self.selectedPaperSize = selectedPaperSize
        self.selectedModelIndex = selectedModelIndex
        
        super.init()
        
        print(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.portName = aDecoder.decodeObject(forKey: "portName") as? String ?? ""
        self.portSettings = aDecoder.decodeObject(forKey: "portSettings") as? String ?? ""
        self.macAddress = aDecoder.decodeObject(forKey: "macAddress") as? String ?? ""
        self.modelName = aDecoder.decodeObject(forKey: "modelName") as? String ?? ""
        self.emulation = StarIoExtEmulation(rawValue: aDecoder.decodeInteger(forKey: "emulation"))!
        self.cashDrawerOpenActiveHigh = aDecoder.decodeBool(forKey: "cashDrawerOpenActiveHigh")
        self.selectedPaperSize = PaperSizeIndex(rawValue: aDecoder.decodeInteger(forKey: "selectedPaperSize")) ?? PaperSizeIndex.twoInch
        self.selectedModelIndex = ModelIndex(rawValue: aDecoder.decodeInteger(forKey: "selectedModelIndex")) ?? ModelIndex.none
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(portName, forKey: "portName")
        aCoder.encode(portSettings, forKey: "portSettings")
        aCoder.encode(macAddress, forKey: "macAddress")
        aCoder.encode(modelName, forKey: "modelName")
        aCoder.encode(emulation.rawValue, forKey: "emulation")
        aCoder.encode(cashDrawerOpenActiveHigh, forKey: "cashDrawerOpenActiveHigh")
        aCoder.encode(selectedPaperSize.rawValue, forKey: "selectedPaperSize")
        aCoder.encode(selectedModelIndex.rawValue, forKey: "selectedModelIndex")
    }
    
    override var description: String {
        return """
        PrinterSetting
        {
            portName: \(self.portName)
            portSettings: \(self.portSettings)
            macAddress: \(self.macAddress)
            modelName: \(self.modelName)
            emulation: \(self.emulation.rawValue)
            cashDrawerOpenActiveHigh: \(self.cashDrawerOpenActiveHigh)
            selectedPaperSize: \(self.selectedPaperSize)
            selectedModelIndex: \(self.selectedModelIndex)
        }
        """
    }
}

class SettingManager: NSObject {
    var settings: [PrinterSetting?]
    
    override init() {
        self.settings = [nil, nil]
        
        super.init()
    }
    
    func save() {

        let encodedData: Data?
        
        if #available(iOS 11.0, *) {
           encodedData = try? NSKeyedArchiver.archivedData(withRootObject: settings, requiringSecureCoding: false)
        } else {
            encodedData = NSKeyedArchiver.archivedData(withRootObject: settings)
        }
        
        UserDefaults.standard.set(encodedData, forKey: "setting")
        UserDefaults.standard.synchronize()
    }
    
    func load() {
        let optEncodedData = UserDefaults.standard.data(forKey: "setting")
        if let encodedData = optEncodedData {
            do{
                self.settings =  try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as? [PrinterSetting?] ?? [nil,nil]
            }catch {
                self.settings = [nil,nil]
            }
        }

    }
}
