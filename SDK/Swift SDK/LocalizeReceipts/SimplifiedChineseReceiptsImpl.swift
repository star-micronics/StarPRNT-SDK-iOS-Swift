//
//  SimplifiedChineseReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class SimplifiedChineseReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "zh-CN"
        
        characterCode = StarIoExtCharacterCode.simplifiedChinese
    }
    
    override func append2inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "STAR便利店\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "欢迎光临\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.append((
            "Unit 1906-08, 19/F,\n" +
            "Enterprise Square 2,\n" +
            "3 Sheung Yuet Road,\n" +
            "Kowloon Bay, KLN\n" +
            "\n" +
            "Tel : (852) 2795 2335\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "货品名称           数量     价格\n" +
            "--------------------------------\n" +
            "\n" +
            "罐装可乐\n" +
            "* Coke                 1    7.00\n" +
            "纸包柠檬茶\n" +
            "* Lemon Tea            2   10.00\n" +
            "热狗\n" +
            "* Hot Dog              1   10.00\n" +
            "薯片(50克装)\n" +
            "* Potato Chips(50g)    1   11.00\n" +
            "--------------------------------\n" +
            "\n" +
            "              总数 :       38.00\n" +
            "              现金 :       38.00\n" +
            "              找赎 :        0.00\n" +
            "\n" +
            "卡号码 Card No.       : 88888888\n" +
            "卡余额 Remaining Val.    : 88.00\n" +
            "机号   Device No.       : 1234F1\n" +
            "\n" +
            "\n" +
            "DD/MM/YYYY  HH:MM:SS\n" +
            "交易编号 : 88888\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "收银机 : 001  收银员 : 180\n" +
            "\n").data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func append3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "STAR便利店\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "欢迎光临\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.append((
            "Unit 1906-08, 19/F, Enterprise Square 2,\n" +
                "　3 Sheung Yuet Road, Kowloon Bay, KLN\n" +
                "\n" +
                "Tel : (852) 2795 2335\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "货品名称   　            数量   　   价格\n" +
            "------------------------------------------------\n" +
            "\n" +
            "罐装可乐\n" +
            "* Coke                      1        7.00\n" +
            "纸包柠檬茶\n" +
            "* Lemon Tea                 2       10.00\n" +
            "热狗\n" +
            "* Hot Dog                   1       10.00\n" +
            "薯片(50克装)\n" +
            "* Potato Chips(50g)         1       11.00\n" +
            "------------------------------------------------\n" +
            "\n" +
            "                         总数 :     38.00\n" +
            "                         现金 :     38.00\n" +
            "                         找赎 :      0.00\n" +
            "\n" +
            "卡号码 Card No.       : 88888888\n" +
            "卡余额 Remaining Val. : 88.00\n" +
            "机号   Device No.     : 1234F1\n" +
            "\n" +
            "\n" +
            "DD/MM/YYYY  HH:MM:SS  交易编号 : 88888\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("收银机 : 001  收银员 : 180\n".data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func append4inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "STAR便利店\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "欢迎光临\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.append((
            "Unit 1906-08, 19/F, Enterprise Square 2,\n" +
            "　3 Sheung Yuet Road, Kowloon Bay, KLN\n" +
            "\n" +
            "Tel : (852) 2795 2335\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "货品名称   　                      数量        　         价格\n" +
            "----------------------------------------------------------------\n" +
            "\n" +
            "罐装可乐\n" +
            "* Coke                               1                    7.00\n" +
            "纸包柠檬茶\n" +
            "* Lemon Tea                          2                   10.00\n" +
            "热狗\n" +
            "* Hot Dog                            1                   10.00\n" +
            "薯片(50克装)\n" +
            "* Potato Chips(50g)                  1                   11.00\n" +
            "----------------------------------------------------------------\n" +
            "\n" +
            "                                   总数 :                38.00\n" +
            "                                   现金 :                38.00\n" +
            "                                   找赎 :                 0.00\n" +
            "\n" +
            "卡号码 Card No.                   : 88888888\n" +
            "卡余额 Remaining Val.             : 88.00\n" +
            "机号   Device No.                 : 1234F1\n" +
            "\n" +
            "\n" +
            "DD/MM/YYYY  HH:MM:SS        交易编号 : 88888\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("收银机 : 001  收银员 : 180\n".data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　     　　STAR便利店\n" +
        "           欢迎光临\n" +
        "\n" +
        "Unit 1906-08,19/F,\n" +
        "  Enterprise Square 2,\n" +
        "  3 Sheung Yuet Road,\n" +
        "  Kowloon Bay, KLN\n" +
        "\n" +
        "Tel: (852) 2795 2335\n" +
        "\n" +
        "货品名称            数量   价格\n" +
        "-----------------------------\n" +
        "罐装可乐\n" +
        "* Coke              1    7.00\n" +
        "纸包柠檬茶\n" +
        "* Lemon Tea         2   10.00\n" +
        "热狗\n" +
        "* Hot Dog           1   10.00\n" +
        "薯片(50克装)\n" +
        "* Potato Chips(50g) 1   11.00\n" +
        "-----------------------------\n" +
        "\n" +
        "               总　数 :  38.00\n" +
        "               现　金 :  38.00\n" +
        "               找　赎 :   0.00\n" +
        "\n" +
        "卡号码 Card No. :    88888888\n" +
        "卡余额 Remaining Val. : 88.00\n" +
        "机号　 Device No. :    1234F1\n" +
        "\n" +
        "DD/MM/YYYY HH:MM:SS\n" +
        "交易编号: 88888\n" +
        "\n" +
        "      收银机:001  收银员:180\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 11 * 2)!
//      let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　  　　STAR便利店\n" +
        "                欢迎光临\n" +
        "\n" +
        "Unit 1906-08,19/F,Enterprise Square 2,\n" +
        "  3 Sheung Yuet Road, Kowloon Bay, KLN\n" +
        "\n" +
        "Tel: (852) 2795 2335\n" +
        "\n" +
        "货品名称                 数量   　  价格\n" +
        "---------------------------------------\n" +
        "罐装可乐\n" +
        "* Coke                   1        7.00\n" +
        "纸包柠檬茶\n" +
        "* Lemon Tea              2       10.00\n" +
        "热狗\n" +
        "* Hot Dog                1       10.00\n" +
        "薯片(50克装)\n" +
        "* Potato Chips(50g)      1       11.00\n" +
        "---------------------------------------\n" +
        "\n" +
        "                        总　数 :  38.00\n" +
        "                        现　金 :  38.00\n" +
        "                        找　赎 :   0.00\n" +
        "\n" +
        "卡号码 Card No.        :       88888888\n" +
        "卡余额 Remaining Val.  :       88.00\n" +
        "机号　 Device No.      :       1234F1\n" +
        "\n" +
        "DD/MM/YYYY   HH:MM:SS   交易编号: 88888\n" +
        "\n" +
        "          收银机:001  收银员:180\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　  　　         STAR便利店\n" +
        "                          欢迎光临\n" +
        "\n" +
        "     Unit 1906-08,19/F,Enterprise Square 2,\n" +
        "                3 Sheung Yuet Road, Kowloon Bay, KLN\n" +
        "\n" +
        "Tel: (852) 2795 2335\n" +
        "\n" +
        "货品名称                               数量          价格\n" +
        "---------------------------------------------------------\n" +
        "罐装可乐\n" +
        "* Coke                                 1            7.00\n" +
        "纸包柠檬茶\n" +
        "* Lemon Tea                            2           10.00\n" +
        "热狗\n" +
        "* Hot Dog                              1           10.00\n" +
        "薯片(50克装)\n" +
        "* Potato Chips(50g)                    1           11.00\n" +
        "---------------------------------------------------------\n" +
        "\n" +
        "                                          总　数 :  38.00\n" +
        "                                          现　金 :  38.00\n" +
        "                                          找　赎 :   0.00\n" +
        "\n" +
        "卡号码 Card No.        :       88888888\n" +
        "卡余额 Remaining Val.  :       88.00\n" +
        "机号　 Device No.      :       1234F1\n" +
        "\n" +
        "DD/MM/YYYY              HH:MM:SS          交易编号: 88888\n" +
        "\n" +
        "                   收银机:001  收银员:180\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "SimplifiedChineseCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　　STAR便利店\n" +
        "              欢迎光临\n" +
        "\n" +
        "Unit 1906-08,19/F,\n" +
        "  Enterprise Square 2,\n" +
        "  3 Sheung Yuet Road,\n" +
        "  Kowloon Bay, KLN\n" +
        "\n" +
        "Tel: (852) 2795 2335\n" +
        "\n" +
        "货品名称              数量   　  价格\n" +
        "-----------------------------------\n" +
        "罐装可乐\n" +
        "* Coke                1        7.00\n" +
        "纸包柠檬茶\n" +
        "* Lemon Tea           2       10.00\n" +
        "热狗\n" +
        "* Hot Dog             1       10.00\n" +
        "薯片(50克装)\n" +
        "* Potato Chips(50g)   1       11.00\n" +
        "-----------------------------------\n" +
        "\n" +
        "                     总　数 :  38.00\n" +
        "                     现　金 :  38.00\n" +
        "                     找　赎 :   0.00\n" +
        "\n" +
        "卡号码 Card No.        :    88888888\n" +
        "卡余额 Remaining Val.  :    88.00\n" +
        "机号　 Device No.      :    1234F1\n" +
        "\n" +
        "DD/MM/YYYY HH:MM:SS  交易编号: 88888\n" +
        "\n" +
        "          收银机:001  收银员:180\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 512)     // EscPos3inch(512dots)
    }
    
    override func appendEscPos3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "STAR便利店\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "欢迎光临\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.append((
            "Unit 1906-08, 19/F, Enterprise Square 2,\n" +
            "　3 Sheung Yuet Road, Kowloon Bay, KLN\n" +
            "\n" +
            "Tel : (852) 2795 2335\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "货品名称   　        数量   　 价格\n" +
            "------------------------------------------\n" +
            "\n" +
            "罐装可乐\n" +
            "* Coke                  1      7.00\n" +
            "纸包柠檬茶\n" +
            "* Lemon Tea             2     10.00\n" +
            "热狗\n" +
            "* Hot Dog               1     10.00\n" +
            "薯片(50克装)\n" +
            "* Potato Chips(50g)     1     11.00\n" +
            "------------------------------------------\n" +
            "\n" +
            "                   总数 :     38.00\n" +
            "                   现金 :     38.00\n" +
            "                   找赎 :      0.00\n" +
            "\n" +
            "卡号码 Card No.       : 88888888\n" +
            "卡余额 Remaining Val. : 88.00\n" +
            "机号   Device No.     : 1234F1\n" +
            "\n" +
            "\n" +
            "DD/MM/YYYY  HH:MM:SS  交易编号 : 88888\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("收银机 : 001  收银员 : 180\n".data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func appendDotImpact3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: (
            "STAR便利店\n" +
            "欢迎光临\n").data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.append((
            "Unit 1906-08, 19/F, Enterprise Square 2,\n" +
            "　3 Sheung Yuet Road, Kowloon Bay, KLN\n" +
            "\n" +
            "Tel : (852) 2795 2335\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "货品名称   　          数量  　   价格\n" +
            "------------------------------------------\n" +
            "\n" +
            "罐装可乐\n" +
            "* Coke                   1        7.00\n" +
            "纸包柠檬茶\n" +
            "* Lemon Tea              2       10.00\n" +
            "热狗\n" +
            "* Hot Dog                1       10.00\n" +
            "薯片(50克装)\n" +
            "* Potato Chips(50g)      1       11.00\n" +
            "------------------------------------------\n" +
            "\n" +
            "                      总数 :     38.00\n" +
            "                      现金 :     38.00\n" +
            "                      找赎 :      0.00\n" +
            "\n" +
            "卡号码 Card No.       : 88888888\n" +
            "卡余额 Remaining Val. : 88.00\n" +
            "机号   Device No.     : 1234F1\n" +
            "\n" +
            "\n" +
            "DD/MM/YYYY  HH:MM:SS  交易编号 : 88888\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("收银机 : 001  收银员 : 180\n".data(using: encoding))
    }
}
