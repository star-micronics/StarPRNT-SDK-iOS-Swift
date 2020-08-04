//
//  JapaneseReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class JapaneseReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "Ja"
        
        characterCode = StarIoExtCharacterCode.japanese
    }
    
    override func append2inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "スター電機\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "修理報告書　兼領収書\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "--------------------------------\n" +
            "発行日時：YYYY年MM月DD日HH時MM分\n" +
            "TEL：054-347-XXXX\n" +
            "\n" +
            "         ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n" +
            "お名前：池西　静子　様\n" +
            "御住所：静岡市清水区七ツ新屋\n" +
            "　　　　５３６番地\n" +
            "伝票番号：No.12345-67890\n" +
            "\n" +
            "　この度は修理をご用命頂き有難うございます。\n" +
            " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
            "\n" +
            "品名／型名　数量　金額　備考\n" +
            "--------------------------------\n" +
            "制御基板　　   1 10,000  配達\n" +
            "操作スイッチ   1  3,800  配達\n" +
            "パネル　　　   1  2,000  配達\n" +
            "技術料　　　   1 15,000\n" +
            "出張費用　　   1  5,000\n" +
            "--------------------------------\n" +
            "\n" +
            "             小計      \\ 35,800\n" +
            "             内税      \\  1,790\n" +
            "             合計      \\ 37,590\n" +
            "\n" +
            "　お問合わせ番号　12345-67890\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
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
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "スター電機\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "修理報告書　兼領収書\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------------\n" +
            "発行日時：YYYY年MM月DD日HH時MM分\n" +
            "TEL：054-347-XXXX\n" +
            "\n" +
            "           ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n" +
            "　お名前：池西　静子　様\n" +
            "　御住所：静岡市清水区七ツ新屋\n" +
            "　　　　　５３６番地\n" +
            "　伝票番号：No.12345-67890\n" +
            "\n" +
            "　この度は修理をご用命頂き有難うございます。\n" +
            " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
            "\n" +
            "品名／型名　          数量      金額　   備考\n" +
            "------------------------------------------------\n" +
            "制御基板　          　  1      10,000     配達\n" +
            "操作スイッチ            1       3,800     配達\n" +
            "パネル　　          　  1       2,000     配達\n" +
            "技術料　          　　  1      15,000\n" +
            "出張費用　　            1       5,000\n" +
            "------------------------------------------------\n" +
            "\n" +
            "                            小計       \\ 35,800\n" +
            "                            内税       \\  1,790\n" +
            "                            合計       \\ 37,590\n" +
            "\n" +
            "　お問合わせ番号　　12345-67890\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
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
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "スター電機\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "修理報告書　兼領収書\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "---------------------------------------------------------------------\n" +
            "発行日時：YYYY年MM月DD日HH時MM分\n" +
            "TEL：054-347-XXXX\n" +
            "\n" +
            "           ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n" +
            "　お名前：池西　静子　様\n" +
            "　御住所：静岡市清水区七ツ新屋\n" +
            "　　　　　５３６番地\n" +
            "　伝票番号：No.12345-67890\n" +
            "\n" +
            "この度は修理をご用命頂き有難うございます。\n" +
            " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
            "\n" +
            "品名／型名　                 数量             金額　          備考\n" +
            "---------------------------------------------------------------------\n" +
            "制御基板　　                   1             10,000            配達\n" +
            "操作スイッチ                   1              3,800            配達\n" +
            "パネル　　　                   1              2,000            配達\n" +
            "技術料　　　                   1             15,000\n" +
            "出張費用　　                   1              5,000\n" +
            "---------------------------------------------------------------------\n" +
            "\n" +
            "                                                 小計       \\ 35,800\n" +
            "                                                 内税       \\  1,790\n" +
            "                                                 合計       \\ 37,590\n" +
            "\n" +
            "　お問合わせ番号　　12345-67890\n" +
            "\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　スター電機\n" +
        "　　　　修理報告書　兼領収書\n" +
        "----------------------------\n" +
        "発行日時：YYYY年MM月DD日HH時MM分\n" +
        "TEL：054-347-XXXX\n" +
        "\n" +
        "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n" +
        "　お名前：池西　静子　様\n" +
        "　御住所：静岡市清水区七ツ新屋\n" +
        "　　　　　５３６番地\n" +
        "　伝票番号：No.12345-67890\n" +
        "\n" +
        "　この度は修理をご用命頂き有難うございます。\n" +
        " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
        "\n" +
        "品名／型名　 数量　　金額\n" +
        "----------------------------\n" +
        "制御基板　　　１　　１０，０００\n" +
        "操作スイッチ　１　　　３，０００\n" +
        "パネル　　　　１　　　２，０００\n" +
        "技術料　　　　１　　１５，０００\n" +
        "出張費用　　　１　　　５，０００\n" +
        "----------------------------\n" +
        "\n" +
        "　　　　　　小計　¥ ３５，８００\n" +
        "　　　　　　内税　¥ 　１，７９０\n" +
        "　　　　　　合計　¥ ３７，５９０\n" +
        "\n" +
        "　お問合わせ番号　　12345-67890\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 11 * 2)!
//      let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　　　　　スター電機\n" +
        "　　　　　　　　修理報告書　兼領収書\n" +
        "---------------------------------------\n" +
        "発行日時：YYYY年MM月DD日HH時MM分\n" +
        "TEL：054-347-XXXX\n" +
        "\n" +
        "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n" +
        "　お名前：池西　静子　様\n" +
        "　御住所：静岡市清水区七ツ新屋\n" +
        "　　　　　５３６番地\n" +
        "　伝票番号：No.12345-67890\n" +
        "\n" +
        "　この度は修理をご用命頂き有難うございます。\n" +
        " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
        "\n" +
        "品名／型名　　　　数量　　　金額　　　　備考\n" +
        "---------------------------------------\n" +
        "制御基板　　　　　　１　１０，０００　　配達\n" +
        "操作スイッチ　　　　１　　３，８００　　配達\n" +
        "パネル　　　　　　　１　　２，０００　　配達\n" +
        "技術料　　　　　　　１　１５，０００\n" +
        "出張費用　　　　　　１　　５，０００\n" +
        "---------------------------------------\n" +
        "\n" +
        "　　　　　　　　　　　　小計　¥ ３５，８００\n" +
        "　　　　　　　　　　　　内税　¥ 　１，７９０\n" +
        "　　　　　　　　　　　　合計　¥ ３７，５９０\n" +
        "\n" +
        "　お問合わせ番号　　12345-67890\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　　　　　　　　　　スター電機\n" +
        "　　　　　　　　　　　　　修理報告書　兼領収書\n" +
        "---------------------------------------------------------\n" +
        "発行日時：YYYY年MM月DD日HH時MM分\n" +
        "TEL：054-347-XXXX\n" +
        "\n" +
        "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n" +
        "　お名前：池西　静子　様\n" +
        "　御住所：静岡市清水区七ツ新屋\n" +
        "　　　　　５３６番地\n" +
        "　伝票番号：No.12345-67890\n" +
        "\n" +
        "　この度は修理をご用命頂き有難うございます。\n" +
        " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
        "\n" +
        "品名／型名　　　　　　　　　数量　　　　　　金額　　　　　　備考\n" +
        "---------------------------------------------------------\n" +
        "制御基板　　　　　　　　　　　１　　　　１０，０００　　　　配達\n" +
        "操作スイッチ　　　　　　　　　１　　　　　３，８００　　　　配達\n" +
        "パネル　　　　　　　　　　　　１　　　　　２，０００　　　　配達\n" +
        "技術料　　　　　　　　　　　　１　　　　１５，０００\n" +
        "出張費用　　　　　　　　　　　１　　　　　５，０００\n" +
        "---------------------------------------------------------\n" +
        "\n" +
        "　　　　　　　　　　　　　　　　　　　　　　小計　¥ ３５，８００\n" +
        "　　　　　　　　　　　　　　　　　　　　　　内税　¥ 　１，７９０\n" +
        "　　　　　　　　　　　　　　　　　　　　　　合計　¥ ３７，５９０\n" +
        "\n" +
        "　お問合わせ番号　　12345-67890\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "JapaneseCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "　　　　　　　 スター電機\n" +
        "　　　　　 修理報告書　兼領収書\n" +
        "-----------------------------------\n" +
        "発行日時：YYYY年MM月DD日HH時MM分\n" +
        "TEL：054-347-XXXX\n" +
        "\n" +
        "　　　　　ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n" +
        "　お名前：池西　静子　様\n" +
        "　御住所：静岡市清水区七ツ新屋\n" +
        "　　　　　５３６番地\n" +
        "　伝票番号：No.12345-67890\n" +
        "\n" +
        "　この度は修理をご用命頂き有難うございます。\n" +
        " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
        "\n" +
        "品名／型名　　　数量　　　金額　　　　備考\n" +
        "-----------------------------------\n" +
        "制御基板　　     １　１０，０００　　配達\n" +
        "操作スイッチ     １　　３，８００　　配達\n" +
        "パネル　　　     １　　２，０００　　配達\n" +
        "技術料　　　     １　１５，０００\n" +
        "出張費用　　     １　　５，０００\n" +
        "-----------------------------------\n" +
        "\n" +
        "　　　　　　　　　　　小計　¥ ３５，８００\n" +
        "　　　　　　　　　　　内税　¥ 　１，７９０\n" +
        "　　　　　　　　　　　合計　¥ ３７，５９０\n" +
        "\n" +
        "　お問合わせ番号　　12345-67890\n"
        
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
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: "スター電機\n".data(using: encoding), height: 3)
        
        builder.appendData(withMultipleHeight: "修理報告書　兼領収書\n".data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------\n" +
            "発行日時：YYYY年MM月DD日HH時MM分\n" +
            "TEL：054-347-XXXX\n" +
            "\n" +
            "           ｲｹﾆｼ  ｼｽﾞｺ   ｻﾏ\n" +
            "　お名前：池西　静子　様\n" +
            "　御住所：静岡市清水区七ツ新屋\n" +
            "　　　　　５３６番地\n" +
            "　伝票番号：No.12345-67890\n" +
            "\n" +
            "　この度は修理をご用命頂き有難うございます。\n" +
            " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
            "\n" +
            "品名／型名        数量      金額　   備考\n" +
            "------------------------------------------\n" +
            "制御基板　          1     10,000     配達\n" +
            "操作スイッチ        1      3,800     配達\n" +
            "パネル　　          1      2,000     配達\n" +
            "技術料　            1     15,000\n" +
            "出張費用　　        1      5,000\n" +
            "------------------------------------------\n" +
            "\n" +
            "                      小計       \\ 35,800\n" +
            "                      内税       \\  1,790\n" +
            "                      合計       \\ 37,590\n" +
            "\n" +
            "　お問合わせ番号　　12345-67890\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
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
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendEmphasis(true)
        
        builder.appendData(withMultipleHeight: (
            "スター電機\n" +
            "修理報告書　兼領収書\n").data(using: encoding), height: 2)
        
        builder.appendEmphasis(false)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------\n" +
            "発行日時：YYYY年MM月DD日HH時MM分\n" +
            "TEL：054-347-XXXX\n" +
            "\n" +
            "        ｲｹﾆｼ  ｼｽﾞｺ  ｻﾏ\n" +
            "　お名前：池西  静子　様\n" +
            "　御住所：静岡市清水区七ツ新屋\n" +
            "　　　　　５３６番地\n" +
            "　伝票番号：No.12345-67890\n" +
            "\n" +
            "　この度は修理をご用命頂き有難うございます。\n" +
            " 今後も故障など発生した場合はお気軽にご連絡ください。\n" +
            "\n" +
            "品名／型名　     数量      金額　     備考\n" +
            "------------------------------------------\n" +
            "制御基板　　       1      10,000     配達\n" +
            "操作スイッチ       1       3,800     配達\n" +
            "パネル　　　       1       2,000     配達\n" +
            "技術料　　　       1      15,000\n" +
            "出張費用　　       1       5,000\n" +
            "------------------------------------------\n" +
            "\n" +
            "                       小計       \\ 35,800\n" +
            "                       内税       \\  1,790\n" +
            "                       合計       \\ 37,590\n" +
            "\n" +
            "　お問合わせ番号　　12345-67890\n").data(using: encoding))
    }
    
    override func appendTextLabelData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendCharacterSpace(0)
        
        builder.appendUnitFeed(20 * 2)
        
        builder.appendMultipleHeight(2)
        
        builder.append("〒422-8654".data(using: encoding))
        
        builder.appendUnitFeed(64)
        
        builder.append("静岡県静岡市駿河区中吉田20番10号".data(using: encoding))
        
        builder.appendUnitFeed(64)
        
        builder.append("スター精密株式会社".data(using: encoding))
        
        builder.appendUnitFeed(64)
        
        builder.appendMultipleHeight(1)
    }
    
    override func createPasteTextLabelString() -> String {
        return "〒422-8654\n" +
               "静岡県静岡市駿河区中吉田20番10号\n" +
               "スター精密株式会社"
    }
    
    override func appendPasteTextLabelData(_ builder: ISCBBuilder, pasteText: String, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.shiftJIS
            
            builder.append(SCBCodePageType.CP932)
        }
        
        builder.append(SCBInternationalType.japan)
        
        builder.appendCharacterSpace(0)
        
        builder.append(pasteText.data(using: encoding))
    }
}
