//
//  TraditionalChineseReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class TraditionalChineseReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "zh-TW"
        
        characterCode = StarIoExtCharacterCode.traditionalChinese
    }
    
    override func append2inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.big5.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "Star Micronics\n".data(using: encoding), height: 3)
        
        builder.appendEmphasis(false)
        
        builder.append("--------------------------------\n".data(using: encoding))
        
        builder.appendData(withMultiple: (
            "電子發票證明聯\n" +
            "103年01-02月\n" +
            "EV-99999999\n").data(using: encoding), width: 2, height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "2014/01/15 13:00\n" +
            "隨機碼 : 9999    總計 : 999\n" +
            "賣方 : 99999999\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: encoding),              model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.Q, cell: 5)
        builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: String.Encoding.ascii), model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.Q, cell: 5)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換請持本聯及銷貨明細表。\n" +
            "9999999-9999999 999999-999999 9999\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: "銷貨明細表 　(銷售)\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.appendData(withAlignment: "2014-01-15 13:00:02\n".data(using: encoding), position: SCBAlignmentPosition.right)
        
        builder.append((
            "\n" +
            "烏龍袋茶2g20入       55 x2 110TX\n" +
            "茉莉烏龍茶2g20入     55 x2 110TX\n" +
            "天仁觀音茶2g*20      55 x2 110TX\n").data(using: encoding))
        
        builder.appendData(withEmphasis: (
            "      小　 計 :              330\n" +
            "      總   計 :              330\n").data(using: encoding))
        
        builder.append((
            "--------------------------------\n" +
            "現 金                        400\n" +
            "      找　 零 :               70\n").data(using: encoding))
        
        builder.appendData(withEmphasis: " 101 發票金額 :              330\n".data(using: encoding))
        
        builder.append((
            "2014-01-15 13:00\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換、贈品及停車兌換請持本聯。\n" +
            "9999999-9999999 999999-999999 9999\n").data(using: encoding))
    }
    
    override func append3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.big5.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "Star Micronics\n".data(using: encoding), height: 3)
        
        builder.appendEmphasis(false)
        
        builder.append("------------------------------------------------\n".data(using: encoding))
        
        builder.appendData(withMultiple: (
            "電子發票證明聯\n" +
            "103年01-02月\n" +
            "EV-99999999\n").data(using: encoding), width: 2, height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "2014/01/15 13:00\n" +
            "隨機碼 : 9999    總計 : 999\n" +
            "賣方 : 99999999\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: encoding),              model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.Q, cell: 5)
        builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: String.Encoding.ascii), model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.Q, cell: 5)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換請持本聯及銷貨明細表。\n" +
            "9999999-9999999 999999-999999 9999\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: "銷貨明細表 　(銷售)\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.appendData(withAlignment: "2014-01-15 13:00:02\n".data(using: encoding), position: SCBAlignmentPosition.right)
        
        builder.append((
            "\n" +
            "烏龍袋茶2g20入                55 x2 110TX\n" +
            "茉莉烏龍茶2g20入              55 x2 110TX\n" +
            "天仁觀音茶2g*20               55 x2 110TX\n").data(using: encoding))
        
        builder.appendData(withEmphasis: (
            "      小　 計 :                330\n" +
            "      總   計 :                330\n").data(using: encoding))
        
        builder.append((
            "------------------------------------------------\n" +
            "現 金                          400\n" +
            "      找　 零 :                 70\n").data(using: encoding))
        
        builder.appendData(withEmphasis: " 101 發票金額 :                330\n".data(using: encoding))
        
        builder.append((
            "2014-01-15 13:00\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換、贈品及停車兌換請持本聯。\n" +
            "9999999-9999999 999999-999999 9999\n").data(using: encoding))
    }
    
    override func append4inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.big5.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "Star Micronics\n".data(using: encoding), height: 3)
        
        builder.appendEmphasis(false)
        
        builder.append("---------------------------------------------------------------------\n".data(using: encoding))
        
        builder.appendData(withMultiple: (
            "電子發票證明聯\n" +
            "103年01-02月\n" +
            "EV-99999999\n").data(using: encoding), width: 2, height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "2014/01/15 13:00\n" +
            "隨機碼 : 9999    總計 : 999\n" +
            "賣方 : 99999999\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: encoding),              model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.Q, cell: 5)
        builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: String.Encoding.ascii), model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.Q, cell: 5)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換請持本聯及銷貨明細表。\n" +
            "9999999-9999999 999999-999999 9999\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: "銷貨明細表 　(銷售)\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.appendData(withAlignment: "2014-01-15 13:00:02\n".data(using: encoding), position: SCBAlignmentPosition.right)
        
        builder.append((
            "\n" +
            "烏龍袋茶2g20入                                    55 x2 110TX\n" +
            "茉莉烏龍茶2g20入                                  55 x2 110TX\n" +
            "天仁觀音茶2g*20                                   55 x2 110TX\n").data(using: encoding))
        
        builder.appendData(withEmphasis: (
            "      小　 計 :                                    330\n" +
            "      總   計 :                                    330\n").data(using: encoding))
        
        builder.append((
            "---------------------------------------------------------------------\n" +
            "現 金                                              400\n" +
            "      找　 零 :                                     70\n").data(using: encoding))
        
        builder.appendData(withEmphasis: " 101 發票金額 :                                    330\n".data(using: encoding))
        
        builder.append((
            "2014-01-15 13:00\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換、贈品及停車兌換請持本聯。\n" +
            "9999999-9999999 999999-999999 9999\n").data(using: encoding))
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　Star Micronics\n" +
        "-----------------------------\n" +
        "        電子發票證明聯\n" +
        "        103年01-02月\n" +
        "        EV-99999999\n" +
        "2014/01/15 13:00\n" +
        "隨機碼 : 9999      總計 : 999\n" +
        "賣　方 : 99999999\n" +
        "\n" +
        "商品退換請持本聯及銷貨明細表。\n" +
        "9999999-9999999 999999-999999 9999\n" +
        "\n" +
        "\n" +
        "        銷貨明細表 　(銷售)\n" +
        "     2014-01-15 13:00:02\n" +
        "\n" +
        "烏龍袋茶2g20入　   55 x2  110TX\n" +
        "茉莉烏龍茶2g20入   55 x2  110TX\n" +
        "天仁觀音茶2g*20　  55 x2  110TX\n" +
        "     小　　計 :　　         330\n" +
        "     總　　計 :　　         330\n" +
        "-----------------------------\n" +
        "現　金　　　                400\n" +
        "     找　　零 :　　          70\n" +
        " 101 發票金額 :　　         330\n" +
        "2014-01-15 13:00\n" +
        "\n" +
        "商品退換、贈品及停車兌換請持本聯。\n" +
        "9999999-9999999 999999-999999 9999\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 11 * 2)!
//      let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　 　　　  　　Star Micronics\n" +
        "---------------------------------------\n" +
        "              電子發票證明聯\n" +
        "              103年01-02月\n" +
        "              EV-99999999\n" +
        "2014/01/15 13:00\n" +
        "隨機碼 : 9999      總計 : 999\n" +
        "賣　方 : 99999999\n" +
        "\n" +
        "商品退換請持本聯及銷貨明細表。\n" +
        "9999999-9999999 999999-999999 9999\n" +
        "\n" +
        "\n" +
        "         銷貨明細表 　(銷售)\n" +
        "                    2014-01-15 13:00:02\n" +
        "\n" +
        "烏龍袋茶2g20入　         55 x2    110TX\n" +
        "茉莉烏龍茶2g20入         55 x2    110TX\n" +
        "天仁觀音茶2g*20　        55 x2    110TX\n" +
        "     小　　計 :　　        330\n" +
        "     總　　計 :　　        330\n" +
        "---------------------------------------\n" +
        "現　金　　　               400\n" +
        "     找　　零 :　　         70\n" +
        " 101 發票金額 :　　        330\n" +
        "2014-01-15 13:00\n" +
        "\n" +
        "商品退換、贈品及停車兌換請持本聯。\n" +
        "9999999-9999999 999999-999999 9999\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　 　　　  　  　       Star Micronics\n" +
        "---------------------------------------------------------\n" +
        "                       電子發票證明聯\n" +
        "                       103年01-02月\n" +
        "                       EV-99999999\n" +
        "2014/01/15 13:00\n" +
        "隨機碼 : 9999      總計 : 999\n" +
        "賣　方 : 99999999\n" +
        "\n" +
        "商品退換請持本聯及銷貨明細表。\n" +
        "9999999-9999999 999999-999999 9999\n" +
        "\n" +
        "\n" +
        "                      銷貨明細表 　(銷售)\n" +
        "                                      2014-01-15 13:00:02\n" +
        "\n" +
        "烏龍袋茶2g20入　                   55 x2        110TX\n" +
        "茉莉烏龍茶2g20入                   55 x2        110TX\n" +
        "天仁觀音茶2g*20　                  55 x2        110TX\n" +
        "     小　　計 :　　                  330\n" +
        "     總　　計 :　　                  330\n" +
        "---------------------------------------------------------\n" +
        "現　金　　　                         400\n" +
        "     找　　零 :　　                   70\n" +
        " 101 發票金額 :　　                  330\n" +
        "2014-01-15 13:00\n" +
        "\n" +
        "商品退換、贈品及停車兌換請持本聯。\n" +
        "9999999-9999999 999999-999999 9999\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "TraditionalChineseCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　 　  　　Star Micronics\n" +
        "-----------------------------------\n" +
        "           電子發票證明聯\n" +
        "           103年01-02月\n" +
        "           EV-99999999\n" +
        "2014/01/15 13:00\n" +
        "隨機碼 : 9999      總計 : 999\n" +
        "賣　方 : 99999999\n" +
        "\n" +
        "商品退換請持本聯及銷貨明細表。\n" +
        "9999999-9999999 999999-999999 9999\n" +
        "\n" +
        "\n" +
        "         銷貨明細表 　(銷售)\n" +
        "            2014-01-15 13:00:02\n" +
        "\n" +
        "烏龍袋茶2g20入　     55 x2    110TX\n" +
        "茉莉烏龍茶2g20入     55 x2    110TX\n" +
        "天仁觀音茶2g*20　    55 x2    110TX\n" +
        "     小　　計 :　　        330\n" +
        "     總　　計 :　　        330\n" +
        "-----------------------------------\n" +
        "現　金　　　               400\n" +
        "     找　　零 :　　         70\n" +
        " 101 發票金額 :　　        330\n" +
        "2014-01-15 13:00\n" +
        "\n" +
        "商品退換、贈品及停車兌換請持本聯。\n" +
        "9999999-9999999 999999-999999 9999\n"
        
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
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.big5.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "Star Micronics\n".data(using: encoding), height: 3)
        
        builder.appendEmphasis(false)
        
        builder.append("------------------------------------------\n".data(using: encoding))
        
        builder.appendData(withMultiple: (
            "電子發票證明聯\n" +
            "103年01-02月\n" +
            "EV-99999999\n").data(using: encoding), width: 2, height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "2014/01/15 13:00\n" +
            "隨機碼 : 9999    總計 : 999\n" +
            "賣方 : 99999999\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: encoding),              model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.Q, cell: 5)
        builder.appendQrCodeData("http://www.star-m.jp/eng/index.html".data(using: String.Encoding.ascii), model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.Q, cell: 5)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換請持本聯及銷貨明細表。\n" +
            "9999999-9999999 999999-999999 9999\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: "銷貨明細表 　(銷售)\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.appendData(withAlignment: "2014-01-15 13:00:02\n".data(using: encoding), position: SCBAlignmentPosition.right)
        
        builder.append((
            "\n" +
            "烏龍袋茶2g20入                55 x2 110TX\n" +
            "茉莉烏龍茶2g20入              55 x2 110TX\n" +
            "天仁觀音茶2g*20               55 x2 110TX\n").data(using: encoding))
        
        builder.appendData(withEmphasis: (
            "      小　 計 :                330\n" +
            "      總   計 :                330\n").data(using: encoding))
        
        builder.append((
            "------------------------------------------\n" +
            "現 金                          400\n" +
            "      找　 零 :                 70\n").data(using: encoding))
        
        builder.appendData(withEmphasis: " 101 發票金額 :                330\n".data(using: encoding))
        
        builder.append((
            "2014-01-15 13:00\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "\n" +
            "商品退換、贈品及停車兌換請持本聯。\n" +
            "9999999-9999999 999999-999999 9999\n").data(using: encoding))
    }
    
    override func appendDotImpact3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.big5.rawValue)))
            
//          builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "Star Micronics\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.append("------------------------------------------\n".data(using: encoding))
        
        builder.appendData(withMultipleWidth: (
            "電子發票證明聯\n" +
            "103年01-02月\n" +
            "EV-99999999\n").data(using: encoding), width: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "2014/01/15 13:00\n" +
            "隨機碼 : 9999    總計 : 999\n" +
            "賣方 : 99999999\n" +
            "\n" +
            "商品退換請持本聯及銷貨明細表。\n" +
            "9999999-9999999 999999-999999 9999\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: "銷貨明細表 　(銷售)\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.appendData(withAlignment: "2014-01-15 13:00:02\n".data(using: encoding), position: SCBAlignmentPosition.right)
        
        builder.append((
            "\n" +
            "烏龍袋茶2g20入             55 x2 110TX\n" +
            "茉莉烏龍茶2g20入           55 x2 110TX\n" +
            "天仁觀音茶2g*20            55 x2 110TX\n").data(using: encoding))
        
        builder.appendData(withEmphasis: (
            "      小　 計 :             330\n" +
            "      總   計 :             330\n").data(using: encoding))
        
        builder.append((
            "------------------------------------------\n" +
            "現 金                       400\n" +
            "      找　 零 :              70\n").data(using: encoding))
        
        builder.appendData(withEmphasis: " 101 發票金額 :             330\n".data(using: encoding))
        
        builder.append((
            "2014-01-15 13:00\n" +
            "\n" +
            "商品退換、贈品及停車兌換請持本聯。\n" +
            "9999999-9999999 999999-999999 9999\n").data(using: encoding))
    }
}
