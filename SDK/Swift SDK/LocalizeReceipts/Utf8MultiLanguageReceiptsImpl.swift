//
//  Utf8MultiLanguageReceiptsImpl.swift
//  Swift SDK
//
//  Created by *** on 2018/**/**.
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

import Foundation

class Utf8MultiLanguageReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "CJK"
        
        characterCode = StarIoExtCharacterCode.standard
    }
    
    override func append2inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding = String.Encoding.utf8
        
        // This function is supported by TSP650II(JP2/TW models only) with F/W version 4.0 or later and mC-Print 2/3.
        // Switch Kanji/Hangul font by specifying the font for Unicode CJK Unified Ideographs before each word.
        
        builder.append(SCBCodePageType.UTF8)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("2017 / 5 / 15 AM 10:00\n".data(using: encoding))
        
        builder.appendMultiple(2, height: 2);
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.japanese.rawValue)])
        builder.append("受付票 ".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.traditionalChinese.rawValue)])
        builder.append("排號單\n".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.simplifiedChinese.rawValue)])
        builder.append("排号单 ".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.hangul.rawValue)])
        builder.append("접수표\n\n".data(using: encoding))
        
        builder.appendMultiple(1, height: 1);
        
        builder.appendCjkUnifiedIdeographFont([])
        builder.appendData(withMultiple:"1\n".data(using: encoding), width:6, height:6)
        builder.append("--------------------------------\n".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.japanese.rawValue)])
        builder.append("ご本人がお持ちください。\n".data(using: encoding))
        builder.append("※紛失しないように\nご注意ください。\n".data(using: encoding))
    }
    
    override func append3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding = String.Encoding.utf8
        
        // This function is supported by TSP650II(JP2/TW models only) with F/W version 4.0 or later and mC-Print 2/3.
        // Switch Kanji/Hangul font by specifying the font for Unicode CJK Unified Ideographs before each word.

        builder.append(SCBCodePageType.UTF8)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("2017 / 5 / 15 AM 10:00\n".data(using: encoding))
        
        builder.appendMultiple(2, height: 2);
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.japanese.rawValue)])
        builder.append("受付票 ".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.traditionalChinese.rawValue)])
        builder.append("排號單\n".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.simplifiedChinese.rawValue)])
        builder.append("排号单 ".data(using: encoding))
        
        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.hangul.rawValue)])
        builder.append("접수표\n\n".data(using: encoding))
        
        builder.appendMultiple(1, height: 1);
        
        builder.appendCjkUnifiedIdeographFont([])
        builder.appendData(withMultiple:"1\n".data(using: encoding), width:6, height:6)
        builder.append("------------------------------------------\n".data(using: encoding))

        builder.appendCjkUnifiedIdeographFont([NSNumber(value: SCBCjkUnifiedIdeographFont.japanese.rawValue)])
        builder.append("ご本人がお持ちください。\n".data(using: encoding))
        builder.append("※紛失しないようにご注意ください。\n".data(using: encoding))
    }
    
    override func append4inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        // not implemented
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        // not implemented
        return UIImage()
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        // not implemented
        return UIImage()
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        // not implemented
        return UIImage()
    }
    
    override func createCouponImage() -> UIImage {
        // not implemented
        return UIImage()
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        // not implemented
        return UIImage()
    }
    
    override func appendEscPos3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        // not implemented
    }
    
    override func appendDotImpact3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        // not implemented
    }
    
    override func appendTextLabelData(_ builder: ISCBBuilder, utf8: Bool) {
        // not implemented
    }
    
    override func createPasteTextLabelString() -> String {
        // not implemented
        return ""
    }
    
    override func appendPasteTextLabelData(_ builder: ISCBBuilder, pasteText: String, utf8: Bool) {
        // not implemented
    }
}
