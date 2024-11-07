//
//  PrinterFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

class PrinterFunctions {
    static func createTextReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, utf8: Bool) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        localizeReceipts.appendTextReceiptData(builder, utf8: utf8)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    @MainActor
    static func createRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts) -> Data {
        let image: UIImage = localizeReceipts.createRasterReceiptImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    @MainActor
    static func createScaleRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, bothScale: Bool) -> Data {
        let image: UIImage = localizeReceipts.createScaleRasterReceiptImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false, width: width, bothScale: bothScale)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    @MainActor
    static func createCouponData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, rotation: SCBBitmapConverterRotation) -> Data {
        let image: UIImage = localizeReceipts.createCouponImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false, width: width, bothScale: true, rotation: rotation)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createTextBlackMarkData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, type: SCBBlackMarkType, utf8: Bool) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(type)
        
        localizeReceipts.appendTextLabelData(builder, utf8: utf8)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
//      builder.append(SCBBlackMarkType.invalid)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createPasteTextBlackMarkData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, pasteText: String, doubleHeight: Bool, type: SCBBlackMarkType, utf8: Bool) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(type)
        
        if doubleHeight == true {
            builder.appendMultipleHeight(2)
            
            localizeReceipts.appendPasteTextLabelData(builder, pasteText: pasteText, utf8: utf8)
            
            builder.appendMultipleHeight(1)
        }
        else {
            localizeReceipts.appendPasteTextLabelData(builder, pasteText: pasteText, utf8: utf8)
        }
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
//      builder.append(SCBBlackMarkType.invalid)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createTextPageModeData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, rect: CGRect, rotation: SCBBitmapConverterRotation, utf8: Bool) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.beginPageMode(rect, rotation:rotation)
        
        localizeReceipts.appendTextLabelData(builder, utf8: utf8)
        
        builder.endPageMode()
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createHoldPrintData(_ emulation: StarIoExtEmulation, isHoldArray: [Bool]) -> [Data] {
        var commandArray : [Data] = [];

        for i in 0..<isHoldArray.count {
            let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)

            builder.beginDocument()
            
            // Disable hold print controlled by printer firmware.
            builder.append(SCBHoldPrintType.invalid)

            if isHoldArray[i] {
                // Enable paper present status if wait paper removal before next printing.
                builder.append(SCBPaperPresentStatusType.valid)
            } else {
                // Disable paper present status if do not wait paper removal before next printing.
                builder.append(SCBPaperPresentStatusType.invalid)
            }
            
            // Create commands for printing.
            builder.appendAlignment(SCBAlignmentPosition.center)
            
            builder.append(("\n------------------------------------\n\n\n\n\n\n").data(using: String.Encoding.ascii))
            
            builder.appendMultiple(3, height: 3)
            
            builder.append(("Page ").data(using: String.Encoding.ascii))
            builder.append((String(i + 1)).data(using: String.Encoding.ascii))
            
            builder.appendMultiple(1, height: 1)
            
            builder.append(("\n\n\n\n\n----------------------------------\n").data(using: String.Encoding.ascii))
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            commandArray.append(builder.commands.copy() as! Data)
        }

        return commandArray;
    }
}
