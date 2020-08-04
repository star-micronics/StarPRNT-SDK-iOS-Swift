//
//  Communication.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

typealias SendCompletionHandler = (_ communicationResult: CommunicationResult) -> Void

typealias SendWithAutoInterfaceSelectCompletionHandler = (_ communicationResult: CommunicationResult, _ portName: String) -> Void

typealias PageStartHandler = (_ index: Int) -> Void

typealias PageFinishHandler = (_ index: Int) -> Void

typealias PrintRedirectionCompletionHandler = (_ communicationResult: Array<(String, CommunicationResult)>) -> Void

typealias SerialNumberCompletionHandler = (_ communicationResult: CommunicationResult, _ serialNumber: String) -> Void

typealias SendCompletionHandlerWithNullableString = (_ result: Bool, _ title: String?, _ message: String?) -> Void

typealias RequestStatusCompletionHandler = (_ result: Bool, _ title: String, _ message: String, _ connect: Bool) -> Void

class Communication {
    static func sendCommands(_ commands: Data!, port: SMPort!, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            do {
                if port == nil {
                    break
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorBeginCheckedBlock
                
                try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                result = .errorWritePort
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    var written: UInt32 = 0
                    
                    try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
                
                result = .errorEndCheckedBlock
                
                try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code))
        }
        
        return result == .success
    }
    
    static func sendCommandsDoNotCheckCondition(_ commands: Data!, port: SMPort!, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            do {
                if port == nil {
                    break
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorWritePort
                
                try port.getParsedStatus(starPrinterStatus: &printerStatus, level: 2)
                
//              if printerStatus.offline == sm_true {     // Do not check condition.
//                  break
//              }
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    var written: UInt32 = 0
                    
                    try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                try port.getParsedStatus(starPrinterStatus: &printerStatus, level: 2)
                
//              if printerStatus.offline == sm_true {     // Do not check condition.
//                  break
//              }
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code))
        }
        
        return result == .success
    }
    
    class func parseDoNotCheckCondition(_ parser: ISCPParser, port: SMPort!, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        let commands: Data = parser.createSendCommands()! as Data
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            do {
                if port == nil {
                    break
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorWritePort
                
                try port.getParsedStatus(starPrinterStatus: &printerStatus, level: 2)
                
//              if printerStatus.offline == sm_true {     // Do not check condition.
//                  break
//              }
                
                var startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    var written: UInt32 = 0
                    
                    try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                result = .errorReadPort
                
                startDate = Date()
                
                var receivedData: [UInt8] = [UInt8]()
                
                while true {
                    var buffer: [UInt8] = [UInt8](repeating: 0, count: 1024 + 8)
                    
                    if Date().timeIntervalSince(startDate) >= 1.0 {     // 1000mS!!!
                        break
                    }
                    
                    Thread.sleep(forTimeInterval: 0.01)     // Break time.
                    
                    var readLength: UInt32 = 0
                    
                    try port.read(readBuffer: &buffer, offset: 0, size: 1024, numberOfBytesRead: &readLength)
                    
                    if readLength == 0 {
                        continue;
                    }
                    
                    let resizedBuffer = buffer.prefix(Int(readLength)).map{ $0 }
                    receivedData.append(contentsOf: resizedBuffer)
                    
                    var receivedDataSize = Int32(receivedData.count)
                    
                    if parser.completionHandler!(&receivedData, &receivedDataSize) == .success {
                        result = .success
                        code = SMStarIOResultCodeSuccess
                        
                        break
                    }
                }
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code))
        }
        
        return result == .success
    }
    
    static func sendCommands(_ commands: Data!, portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            var port : SMPort
            
            do {
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
//              port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: timeout)
                port = try SMPort.getPort(portName: portName, portSettings: portSettings, ioTimeoutMillis: timeout)
                
                defer {
                    SMPort.release(port)
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorBeginCheckedBlock
                
                try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                result = .errorWritePort
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    var written: UInt32 = 0
                    
                    try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
                
                result = .errorEndCheckedBlock
                
                try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code))
        }
        
        return result == .success
    }
    
    static func sendCommandsWithAutoInterfaceSelect(_ commands: Data!, portSettings: String!, timeout: UInt32, completionHandler: SendWithAutoInterfaceSelectCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        var portName = "nil"
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            var port : SMPort
            
            do {
                // Specifying AutoSwitch: for portName allows you to automatically select the interface for connecting to the printer.
                port = try SMPort.getPort(portName: "AutoSwitch:", portSettings: portSettings, ioTimeoutMillis: timeout)
                
                defer {
                    SMPort.release(port)
                }
                
                portName = port.portName()
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorBeginCheckedBlock
                
                try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                result = .errorWritePort
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    var written: UInt32 = 0
                    
                    try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
                
                result = .errorEndCheckedBlock
                
                try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code), portName)
        }
        
        return result == .success
    }
    
    static func sendCommandsMultiplePages(_ commandArray: [Data]!, portName: String!, portSettings: String!, timeout: UInt32, holdPrintTimeout: UInt32, pageStartHandler: PageStartHandler?, pageFinishHandler: PageFinishHandler?, completionHandler: SendCompletionHandler?) -> Bool {
            var result: Result = .errorOpenPort
            var code: Int = SMStarIOResultCodeFailedError
            
            while true {
                var port : SMPort
                
                do {
                    // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                    // (Refer Readme for details)
    //              port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: timeout)
                    port = try SMPort.getPort(portName: portName, portSettings: portSettings, ioTimeoutMillis: timeout)
                    
                    defer {
                        SMPort.release(port)
                    }
                    
                    // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                    // (Refer Readme for details)
                    if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                        Thread.sleep(forTimeInterval: 0.2)
                    }
                    
                    for i in 0..<commandArray.count {
                        let commands = commandArray[i]
                        
                        var commandsUInt8: [UInt8] = [UInt8](repeating: 0, count: commands.count)
                        commands.copyBytes(to: &commandsUInt8, count: commands.count)
                        
                        var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                        
                        result = .errorBeginCheckedBlock
                        
                        port.holdPrintTimeoutMillis = holdPrintTimeout
                        
                        try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                        
                        if printerStatus.offline == sm_true {
                            break
                        }
                        
                        pageStartHandler?(i)
                        
                        result = .errorWritePort
                        
                        let startDate: Date = Date()
                        
                        var total: UInt32 = 0
                        
                        while total < UInt32(commands.count) {
                            var written: UInt32 = 0
                            
                            try port.write(writeBuffer: commandsUInt8, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                            
                            total += written
                            
                            if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                                break
                            }
                        }
                        
                        if total < UInt32(commands.count) {
                            break
                        }
                        
                        port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
                        
                        result = .errorEndCheckedBlock
                        
                        try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                        
                        if printerStatus.offline == sm_true {
                            break
                        }
                        
                        pageFinishHandler?(i)
                        
                        if i == commandArray.count - 1 {
                            result = .success
                            code = SMStarIOResultCodeSuccess
                        }
                    }
                    
                    break
                }
                catch let error as NSError {
                    code = error.code
                    break
                }
            }
            
            completionHandler?(CommunicationResult.init(result, code))
            
            return result == .success
        }


    static func sendCommandsDoNotCheckCondition(_ commands: Data!, portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        while true {
            var port : SMPort
            
            do {
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
//              port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: timeout)
                port = try SMPort.getPort(portName: portName, portSettings: portSettings, ioTimeoutMillis: timeout)
                
                defer {
                    SMPort.release(port)
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorWritePort
                
                try port.getParsedStatus(starPrinterStatus: &printerStatus, level: 2)
                
//              if printerStatus.offline == sm_true {     // Do not check condition.
//                  break
//              }
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < UInt32(commands.count) {
                    var written: UInt32 = 0
                    
                    try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commands.count) {
                    break
                }
                
                try port.getParsedStatus(starPrinterStatus: &printerStatus, level: 2)
                
//              if printerStatus.offline == sm_true {     // Do not check condition.
//                  break
//              }
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code))
        }
        
        return result == .success
    }
    
    static func sendCommandsForPrintReDirection(_ commands: Data!,
                                                timeout: UInt32,
                                                completionHandler: PrintRedirectionCompletionHandler?) {
        var communicationResultArray: [(String, CommunicationResult)] = []
        
        var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &commandsArray, count: commands.count)
        
        for i in 0..<AppDelegate.settingManager.settings.count {
            var result: Result = .errorOpenPort
            var code: Int = SMStarIOResultCodeFailedError
            
            let setting = AppDelegate.settingManager.settings[i]!
            
            while true {
                var port : SMPort
                
                do {
                    // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                    // (Refer Readme for details)
//                  port = try SMPort.getPort(portName: setting.portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: timeout)
                    port = try SMPort.getPort(portName: setting.portName, portSettings: setting.portSettings, ioTimeoutMillis: timeout)
                    
                    defer {
                        SMPort.release(port)
                    }
                    
                    // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                    // (Refer Readme for details)
                    if #available(iOS 11.0, *), setting.portName.uppercased().hasPrefix("BT:") {
                        Thread.sleep(forTimeInterval: 0.2)
                    }
                    
                    var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                    
                    result = .errorBeginCheckedBlock
                    
                    try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                    
                    if printerStatus.offline == sm_true {
                        break
                    }
                    
                    result = .errorWritePort
                    
                    let startDate: Date = Date()
                    
                    var total: UInt32 = 0
                    
                    while total < UInt32(commands.count) {
                        var written: UInt32 = 0
                        
                        try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                        
                        total += written
                        
                        if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                            break
                        }
                    }
                    
                    if total < UInt32(commands.count) {
                        break
                    }
                    
                    port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
                    
                    result = .errorEndCheckedBlock
                    
                    try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                    
                    if printerStatus.offline == sm_true {
                        break
                    }
                    
                    result = .success
                    code = SMStarIOResultCodeSuccess
                    
                    break
                }
                catch let error as NSError {
                    code = error.code
                    break
                }
            }
            
            communicationResultArray.append((setting.portName, CommunicationResult.init(result, code)))
            
            if result == .success {
                break
            }
        }

        DispatchQueue.main.async {
            completionHandler?(communicationResultArray)
        }
    }
    
    static func connectBluetooth(_ completionHandler: SendCompletionHandlerWithNullableString?) {
        EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil) { (error) -> Void in
            var result: Bool = false
            
            var title:   String? = ""
            var message: String? = ""
            
            if let error = error as NSError? {
                NSLog("Error:%@", error.description)
                
                switch error.code {
                case EABluetoothAccessoryPickerError.alreadyConnected.rawValue :
                    title   = "Success"
                    message = ""
                    
                    result = true
                case EABluetoothAccessoryPickerError.resultCancelled.rawValue,
                     EABluetoothAccessoryPickerError.resultFailed.rawValue :
                    title   = nil
                    message = nil
                    
                    result = false
//              case EABluetoothAccessoryPickerErrorCode.ResultNotFound :
                default                                                 :
                    title   = "Fail to Connect"
                    message = ""
                    
                    result = false
                }
            }
            else {
                title = "Success"
                message = ""
                
                result = true
            }
            
            if completionHandler != nil {
                completionHandler!(result, title, message)
            }
        }
    }
    
    static func disconnectBluetooth(_ modelName: String!, portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SendCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        while true {
            var port: SMPort
            
            do {
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
//              port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: timeout)
                port = try SMPort.getPort(portName: portName, portSettings: portSettings, ioTimeoutMillis: timeout)
                
                defer {
                    SMPort.release(port)
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                if modelName.hasPrefix("TSP143IIIBI") == true {
                    let commandArray: [UInt8] = [0x1b, 0x1c, 0x26, 0x49]     // Only TSP143IIIBI
                    
                    var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                    
                    result = .errorBeginCheckedBlock
                    
                    try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
                    
                    if printerStatus.offline == sm_true {
                        break
                    }
                    
                    result = .errorWritePort
                    
                    let startDate: Date = Date()
                    
                    var total: UInt32 = 0
                    
                    while total < UInt32(commandArray.count) {
                        var written: UInt32 = 0
                        
                        try port.write(writeBuffer: commandArray, offset: total, size: UInt32(commandArray.count) - total, numberOfBytesWritten: &written)
                        
                        total += written
                        
                        if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                            break
                        }
                    }
                    
                    if total < UInt32(commandArray.count) {
                        break
                    }
                    
//                  port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
//
//                  result = .errorEndCheckedBlock
//
//                  try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
//
//                  if printerStatus.offline == sm_true {
//                      break
//                  }
                }
                else {
                    result = .errorWritePort
                    
                    try port.disconnectAccessory()
                }
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code))
        }
        
        return result == .success
    }
    
    static func confirmSerialNumber(_ portName: String!, portSettings: String!, timeout: UInt32, completionHandler: SerialNumberCompletionHandler?) -> Bool {
        var result: Result = .errorOpenPort
        var code: Int = SMStarIOResultCodeFailedError
        
        var message: String = ""
        
        while true {
            var port: SMPort
            
            do {
                // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                // (Refer Readme for details)
//              port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: timeout)
                port = try SMPort.getPort(portName: portName, portSettings: portSettings, ioTimeoutMillis: timeout)
                
                defer {
                    SMPort.release(port)
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                result = .errorWritePort
                
                try port.getParsedStatus(starPrinterStatus: &printerStatus, level:2)
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                let commandArray: [UInt8] = [0x1b, 0x1d, 0x29, 0x49, 0x01, 0x00, 49]     // <ESC><GS>')''I'pLpHfn
                
                while total < UInt32(commandArray.count) {
                    var written: UInt32 = 0
                        
                    try port.write(writeBuffer: commandArray,
                                   offset: total,
                                   size: UInt32(commandArray.count) - total,
                                   numberOfBytesWritten: &written)
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 3.0 {     //  3000mS!!!
                        break
                    }
                }
                
                if total < UInt32(commandArray.count) {
                    break
                }
                
                result = .errorReadPort
                
                var information: String = ""
                
                var receivedData: [UInt8] = [UInt8]()
                
                while true {
                    var buffer: [UInt8] = [UInt8](repeating: 0, count: 1024 + 8)
                    
                    if Date().timeIntervalSince(startDate) >= 3.0 {     //  3000mS!!!
                        break
                    }
                    
                    Thread.sleep(forTimeInterval: 0.01)     // Break time.
                    
                    var readLength: UInt32 = 0
                    
                    try port.read(readBuffer: &buffer, offset: 0, size: 1024, numberOfBytesRead: &readLength)
                    
                    if readLength == 0 {
                        continue;
                    }
                    
                    let resizedBuffer = buffer.prefix(Int(readLength)).map{ $0 }
                    receivedData.append(contentsOf: resizedBuffer)
                    
                    if (receivedData.count >= 2) {
                        for i: Int in 0 ..< Int(receivedData.count - 1) {
                            if buffer[i + 0] == 0x0a &&
                               buffer[i + 1] == 0x00 {
                                for j: Int in 0 ..< Int(receivedData.count - 9) {
                                    if buffer[j + 0] == 0x1b &&
                                       buffer[j + 1] == 0x1d &&
                                       buffer[j + 2] == 0x29 &&
                                       buffer[j + 3] == 0x49 &&
                                       buffer[j + 6] == 49 {
                                        information = ""
                                        
                                        for k: Int in j + 7 ..< Int(receivedData.count) {
                                            let text: String = String(format: "%c", buffer[k])
                                            
                                            information += text
                                        }
                                        
                                        result = .success
                                        break
                                    }
                                }
                                
                                break
                            }
                        }
                    }
                    
                    if result == .success {
                        break
                    }
                }
                
                if result != .success {
                    break
                }
                
                result = .errorReadPort
                
                // Extract Serial Number Field ("PrSrN=....,")
                let serialNumberPrefix = "PrSrN="
                let optSerialNumber = information.split(separator: ",")
                    .filter{ $0.hasPrefix(serialNumberPrefix) }
                    .map{ $0.dropFirst(serialNumberPrefix.count) }
                    .first
                
                guard let serialNumber = optSerialNumber else {
                    break
                }
                
                message = String(serialNumber)
                
                result = .success
                code = SMStarIOResultCodeSuccess
                
                break
            }
            catch let error as NSError {
                code = error.code
                break
            }
        }
        
        if completionHandler != nil {
            completionHandler!(CommunicationResult.init(result, code), message)
        }
        
        return result == .success
    }
    
    static func getCommunicationResultMessage(_ communicationResult: CommunicationResult) -> String {
        var message: String
        
        switch communicationResult.result {
        case .success:
            message = "Success!"
        case .errorOpenPort:
            message = "Fail to openPort"
        case .errorBeginCheckedBlock:
            message = "Printer is offline (beginCheckedBlock)"
        case .errorEndCheckedBlock:
            message = "Printer is offline (endCheckedBlock)"
        case .errorReadPort:
            message = "Read port error (readPort)"
        case .errorWritePort:
            message = "Write port error (writePort)"
        default:
            message = "Unknown error"
        }
        
        if communicationResult.result != .success {
            message += "\n\nError code: " + String(communicationResult.code)
            
            if communicationResult.code == SMStarIOResultCodeInUseError {
                message += " (In use)"
            }
            else if communicationResult.code == SMStarIOResultCodeFailedError {
                message += " (Failed)"
            }
            else if communicationResult.code == SMStarIOResultCodePaperPresentError {
                message += " (Paper Present)"
            }
        }
        
        return message
    }
}
