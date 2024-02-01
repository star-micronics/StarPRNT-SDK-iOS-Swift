//
//  CashDrawerFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class CashDrawerFunctions {
    static func createData(_ emulation: StarIoExtEmulation, channel: SCBPeripheralChannel) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendPeripheral(channel)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
}
