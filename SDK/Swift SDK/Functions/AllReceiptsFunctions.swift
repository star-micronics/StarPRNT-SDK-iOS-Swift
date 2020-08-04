//
//  AllReceiptsFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class AllReceiptsFunctions {
    static func createRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, receipt: Bool, info: Bool, qrCode: Bool, completion: @escaping ((Int, Error?) -> Void)) -> Data? {
        let image: UIImage = localizeReceipts.createRasterReceiptImage()!
        
        let urlString: String = SMCSAllReceipts.uploadBitmap(image, completion: completion)
        
        if receipt == true ||
           info    == true ||
           qrCode  == true {
            let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
            
            builder.beginDocument()
            
            if receipt == true {
                builder.appendBitmap(image, diffusion: false)
            }
            
            if info   == true ||
               qrCode == true {
                let allReceiptsData: Data
                
                if emulation == StarIoExtEmulation.starGraphic {
                    let width: Int = AppDelegate.getSelectedPaperSize().rawValue
                    
                    allReceiptsData = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode, width: width)     // Support to centering in Star Graphic.
                }
                else {
                    allReceiptsData = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode)     // Non support to centering in Star Graphic.
                }
                
//              builder.appendData   (allReceiptsData)
                builder.appendRawData(allReceiptsData)
            }
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            return builder.commands.copy() as? Data
        }
        
        return nil
    }
    
    static func createScaleRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, bothScale: Bool, receipt: Bool, info: Bool, qrCode: Bool, completion: @escaping ((Int, Error?) -> Void)) -> Data? {
        let image: UIImage = localizeReceipts.createScaleRasterReceiptImage()!
        
        let urlString: String = SMCSAllReceipts.uploadBitmap(image, completion: completion)
        
        if receipt == true ||
           info    == true ||
           qrCode  == true {
            let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
            
            builder.beginDocument()
            
            if receipt == true {
                builder.appendBitmap(image, diffusion: false, width: width, bothScale: bothScale)
            }
            
            if info   == true ||
               qrCode == true {
                let allReceiptsData: Data
                
                if emulation == StarIoExtEmulation.starGraphic {
                    allReceiptsData = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode, width: width)     // Support to centering in Star Graphic.
                }
                else {
                    allReceiptsData = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode)     // Non support to centering in Star Graphic.
                }
                
//              builder.appendData   (allReceiptsData)
                builder.appendRawData(allReceiptsData)
            }
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            return builder.commands.copy() as? Data
        }
        
        return nil
    }
    
    static func createTextReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, utf8: Bool, width: Int, receipt: Bool, info: Bool, qrCode: Bool, completion: @escaping ((Int, Error?) -> Void)) -> Data? {
//      let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        var builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        localizeReceipts.appendTextReceiptData(builder, utf8: utf8)
        
//      builder.appendCutPaper(SCBCutPaperAction.PartialCutWithFeed)     // No need.
        
        builder.endDocument()
        
        let receiptData: Data = builder.commands.copy() as! Data
        
        let urlString: String = SMCSAllReceipts.uploadData(receiptData, emulation: emulation, characterCode: localizeReceipts.characterCode, width: width, completion: completion)
        
        if receipt == true ||
           info    == true ||
           qrCode  == true {
//          let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
                builder              = StarIoExt.createCommandBuilder(emulation)
            
            builder.beginDocument()
            
            if receipt == true {
                localizeReceipts.appendTextReceiptData(builder, utf8: utf8)
            }
            
            if info   == true ||
               qrCode == true {
                let allReceiptsData: Data = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode)
                
//              builder.appendData   (allReceiptsData)
                builder.appendRawData(allReceiptsData)
            }
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            return builder.commands.copy() as? Data
        }
        
        return nil
    }
}
