//
//  DisplayFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class DisplayFunctions {
    static func appendClearScreen(builder: ISDCBBuilder) {
        builder.appendClearScreen()
    }
    
    static func appendTextPattern(builder: ISDCBBuilder, number: Int) {
//      builder.appendClearScreen()
        builder.append(SDCBCursorMode.off)
        builder.appendSpecifiedPosition(1, y: 1)
        
        let pattern1: [UInt8] = [0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33,
                                 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47]
        
        let pattern2: [UInt8] = [0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b,
                                 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f]
        
        let pattern3: [UInt8] = [0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x80, 0x81, 0x82, 0x83,
                                 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97]
        
        let pattern4: [UInt8] = [0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, 0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab,
                                 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf]
        
        let pattern5: [UInt8] = [0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3,
                                 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf, 0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7]
        
        let pattern6: [UInt8] = [0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb,
                                 0xfc, 0xfd, 0xfe, 0xff, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20]
        
        switch number {
        case 0  : builder.appendBytes(pattern1, length: UInt(pattern1.count))
        case 1  : builder.appendBytes(pattern2, length: UInt(pattern2.count))
        case 2  : builder.appendBytes(pattern3, length: UInt(pattern3.count))
        case 3  : builder.appendBytes(pattern4, length: UInt(pattern4.count))
        case 4  : builder.appendBytes(pattern5, length: UInt(pattern5.count))
        default : builder.appendBytes(pattern6, length: UInt(pattern6.count))     // 5
        }
    }
    
    static func appendGraphicPattern(builder: ISDCBBuilder, number: Int) {
        builder.append(SDCBCursorMode.off)
        
        let image: UIImage?
        
        switch number {
        case 0:
            image = UIImage(named: "DisplayImage1.png")
        case 1:
            image = UIImage(named: "DisplayImage2.png")
        default:
            preconditionFailure()
        }
        
        if let image = image {
            builder.appendBitmap(image, diffusion: true)
        }
    }
    
    static func appendCharacterSet(builder: ISDCBBuilder, internationalType: SDCBInternationalType, codePageType: SDCBCodePageType) {
//      builder.appendClearScreen()
        builder.append(SDCBCursorMode.off)
        builder.appendSpecifiedPosition(1, y: 1)
        
        builder.append(internationalType)
        builder.append(codePageType)
        
        let pattern1: [UInt8] = [0x2d, 0x20, 0x20, 0x20, 0x23, 0x24, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x20, 0x20, 0x2d,
                                 0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3]
        
        let pattern2: [UInt8] = [0x2d, 0x20, 0x20, 0x20, 0x23, 0x24, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x20, 0x20, 0x2d,
                                 0x88, 0xa0, 0x88, 0xa1, 0x88, 0xa2, 0x88, 0xa3, 0x88, 0xa4, 0x88, 0xa5, 0x88, 0xa6, 0x88, 0xa7, 0x88, 0xa8, 0x88, 0xa9]
        
        let pattern3: [UInt8] = [0x2d, 0x20, 0x20, 0x20, 0x23, 0x24, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x20, 0x20, 0x2d,
                                 0xb0, 0xa1, 0xb0, 0xa2, 0xb0, 0xa3, 0xb0, 0xa4, 0xb0, 0xa5, 0xb0, 0xa6, 0xb0, 0xa7, 0xb0, 0xa8, 0xb0, 0xa9, 0xb0, 0xaa]
        
        let pattern4: [UInt8] = [0x2d, 0x20, 0x20, 0x20, 0x23, 0x24, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x20, 0x20, 0x2d,
                                 0xa4, 0x40, 0xa4, 0x41, 0xa4, 0x42, 0xa4, 0x43, 0xa4, 0x44, 0xa4, 0x45, 0xa4, 0x46, 0xa4, 0x47, 0xa4, 0x48, 0xa4, 0x49]
        
        let pattern5: [UInt8] = [0x2d, 0x20, 0x20, 0x20, 0x23, 0x24, 0x40, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x20, 0x20, 0x2d,
                                 0xb0, 0xa1, 0xb0, 0xa2, 0xb0, 0xa3, 0xb0, 0xa4, 0xb0, 0xa5, 0xb0, 0xa6, 0xb0, 0xa7, 0xb0, 0xa8, 0xb0, 0xa9, 0xb0, 0xaa]
        
        switch codePageType {
//      default                                  : builder.appendBytes(pattern1, length: UInt(pattern1.count))     // CP437,Katakana,CP850,CP860,CP863,CP865,CP1252,CP866,CP852,CP858
        case SDCBCodePageType.japanese           : builder.appendBytes(pattern2, length: UInt(pattern2.count))
        case SDCBCodePageType.simplifiedChinese  : builder.appendBytes(pattern3, length: UInt(pattern3.count))
        case SDCBCodePageType.traditionalChinese : builder.appendBytes(pattern4, length: UInt(pattern4.count))
        case SDCBCodePageType.hangul             : builder.appendBytes(pattern5, length: UInt(pattern5.count))
        default                                  : builder.appendBytes(pattern1, length: UInt(pattern1.count))     // CP437,Katakana,CP850,CP860,CP863,CP865,CP1252,CP866,CP852,CP858
        }
    }
    
    static func appendTurnOn(builder: ISDCBBuilder, turnOn: Bool) {
////    builder.appendClearScreen()
        builder.append(SDCBCursorMode.off)
//      builder.appendSpecifiedPosition(1, y: 1)
//
//      let pattern: Data = ("Star Micronics      " +
//                           "Total :        12345").data(using: String.Encoding.ascii)!
//
//      builder.append(pattern)
        
        builder.appendTurn(on: turnOn)
    }
    
    static func appendCursorMode(builder: ISDCBBuilder, cursorMode: SDCBCursorMode) {
//      builder.appendClearScreen()
        builder.append(SDCBCursorMode.off)
        builder.appendSpecifiedPosition(1, y: 1)
        
        let pattern: Data = ("Star Micronics      " +
                             "Total :        12345").data(using: String.Encoding.ascii)!
        
        builder.append(pattern)
        
        builder.appendSpecifiedPosition(20, y: 2)
        
        builder.append(cursorMode)
    }
    
    static func appendContrastMode(builder: ISDCBBuilder, contrastMode: SDCBContrastMode) {
////    builder.appendClearScreen()
//      builder.append(SDCBCursorMode.off)
//      builder.appendSpecifiedPosition(1, y: 1)
//
//      let pattern: Data = ("Star Micronics      " +
//                           "Total :        12345").data(using: String.Encoding.ascii)!
//
//      builder.append(pattern)
        
        builder.append(contrastMode)
    }
    
    static func appendUserDefinedCharacter(builder: ISDCBBuilder, set: Bool) {
//      builder.appendClearScreen()
        builder.append(SDCBCursorMode.off)
        builder.appendSpecifiedPosition(1, y: 1)
        
        builder.append(SDCBInternationalType.USA)
        builder.append(SDCBCodePageType.japanese)
        
        if set {
           
            var sbcsData: [UInt8] = [0x00, 0x00, 0x32, 0x00, 0x49, 0x00, 0x49, 0x7f,
                                     0x26, 0x48, 0x00, 0x48, 0x00, 0x30, 0x00, 0x00]
            
            builder.appendUserDefinedCharacter(0, code: 0x20, font: &sbcsData)
            

            var dbcsData: [UInt8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0x03, 0x20, 0x04, 0x90, 0x04, 0x90, 0x02, 0x60,
                                     0x00, 0x00, 0x07, 0xf0, 0x04, 0x80, 0x04, 0x80,
                                     0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
            
            builder.appendUserDefinedDbcsCharacter(0, code: 0x8140, font: &dbcsData)
            
        }
        else {
            builder.appendUserDefinedCharacter(0, code: 0x00, font:nil)
            
            builder.appendUserDefinedDbcsCharacter(0, code: 0x0000, font:nil)
        }
        
        let pattern: [UInt8] = [0x5b, 0x20, 0x20, 0x53, 0x74, 0x61, 0x72, 0x20, 0x4d, 0x69, 0x63, 0x72, 0x6f, 0x6e, 0x69, 0x63, 0x73, 0x20, 0x20, 0x5d,
                                0x5b, 0x81, 0x40, 0x81, 0x40, 0x83, 0x58, 0x83, 0x5e, 0x81, 0x5b, 0x90, 0xb8, 0x96, 0xa7, 0x81, 0x40, 0x81, 0x40, 0x5d]
        
        builder.appendBytes(pattern, length: UInt(pattern.count))
    }
}
