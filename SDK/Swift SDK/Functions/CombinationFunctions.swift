//
//  CombinationFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class CombinationFunctions {
    static func createTextReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, utf8: Bool) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        localizeReceipts.appendTextReceiptData(builder, utf8: utf8)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.appendPeripheral(SCBPeripheralChannel.no1)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts) -> Data {
        let image: UIImage = localizeReceipts.createRasterReceiptImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.appendPeripheral(SCBPeripheralChannel.no1)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createScaleRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, bothScale: Bool) -> Data {
        let image: UIImage = localizeReceipts.createScaleRasterReceiptImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false, width: width, bothScale: bothScale)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.appendPeripheral(SCBPeripheralChannel.no1)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createCouponData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, rotation: SCBBitmapConverterRotation) -> Data {
        let image: UIImage = localizeReceipts.createCouponImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false, width: width, bothScale: true, rotation: rotation)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.appendPeripheral(SCBPeripheralChannel.no1)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
}
