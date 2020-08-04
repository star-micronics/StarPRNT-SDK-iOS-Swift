//
//  SpanishReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class SpanishReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "Es"
        
        characterCode = StarIoExtCharacterCode.standard
    }
    
    override func append2inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.windowsCP1252
            
            builder.append(SCBCodePageType.CP1252)
        }
        
        builder.append(SCBInternationalType.spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultiple: (
            "BAR RESTAURANT\n" +
            "EL POZO\n").data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "C/.ROCAFORT 187\n" +
            "08029 BARCELONA\n" +
            "\n" +
            "NIF :X-3856907Z\n" +
            "TEL :934199465\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "--------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "--------------------------------\n" +
            " 4  3,00  JARRA  CERVEZA   12,00\n" +
            " 1  1,60  COPA DE CERVEZA   1,60\n" +
            "--------------------------------\n" +
            "               SUB TOTAL : 13,60\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.appendData(withMultipleHeight: "TOTAL:     13,60 EUROS\n".data(using: encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "NO: 000018851     IVA INCLUIDO\n" +
            "--------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "**** GRACIAS POR SU VISITA! ****\n" +
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
            encoding = String.Encoding.windowsCP1252
            
            builder.append(SCBCodePageType.CP1252)
        }
        
        builder.append(SCBInternationalType.spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultiple: "BAR RESTAURANT EL POZO\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "------------------------------------------------\n" +
            " 4     3,00      JARRA  CERVEZA            12,00\n" +
            " 1     1,60      COPA DE CERVEZA            1,60\n" +
            "------------------------------------------------\n" +
            "                           SUB TOTAL :     13,60\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.appendData(withMultipleHeight: "TOTAL:     13,60 EUROS\n".data(using: encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "NO: 000018851  IVA INCLUIDO\n" +
            "------------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").data(using: encoding))
        
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
            encoding = String.Encoding.windowsCP1252
            
            builder.append(SCBCodePageType.CP1252)
        }
        
        builder.append(SCBInternationalType.spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultiple: "BAR RESTAURANT EL POZO\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "---------------------------------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "---------------------------------------------------------------------\n" +
            " 4     3,00          JARRA  CERVEZA                             12,00\n" +
            " 1     1,60          COPA DE CERVEZA                             1,60\n" +
            "---------------------------------------------------------------------\n" +
            "                                         SUB TOTAL :            13,60\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.appendData(withMultipleHeight: "TOTAL:     13,60 EUROS\n".data(using: encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "NO: 000018851  IVA INCLUIDO\n" +
            "---------------------------------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "     BAR RESTAURANT\n" +
        "                   EL POZO\n" +
        "C/.ROCAFORT 187\n" +
        "08029 BARCELONA\n" +
        "NIF :X-3856907Z\n" +
        "TEL :934199465\n" +
        "--------------------------\n" +
        "MESA: 100 P: -\n" +
        "    FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "--------------------------\n" +
        "3,00 JARRA  CERVEZA  12,00\n" +
        "1,60 COPA DE CERVEZA  1,60\n" +
        "--------------------------\n" +
        "         SUB TOTAL : 13,60\n" +
        "TOTAL:         13,60 EUROS\n" +
        " NO:000018851 IVA INCLUIDO\n" +
        "\n" +
        "--------------------------\n" +
        "**GRACIAS POR SU VISITA!**\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                        BAR RESTAURANT\n" +
        "                               EL POZO\n" +
        "C/.ROCAFORT 187\n" +
        "08029 BARCELONA\n" +
        "NIF :X-3856907Z\n" +
        "TEL :934199465\n" +
        "--------------------------------------\n" +
        "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "--------------------------------------\n" +
        "4 3,00 JARRA  CERVEZA   12,00\n" +
        "1 1,60 COPA DE CERVEZA  1,60\n" +
        "--------------------------------------\n" +
        "                     SUB TOTAL : 13,60\n" +
        "TOTAL:               13,60 EUROS\n" +
        "NO: 000018851 IVA INCLUIDO\n" +
        "\n" +
        "--------------------------------------\n" +
        "            **GRACIAS POR SU VISITA!**\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                                   BAR RESTAURANT EL POZO\n" +
        "                          C/.ROCAFORT 187 08029 BARCELONA\n" +
        "                          NIF :X-3856907Z  TEL :934199465\n" +
        "---------------------------------------------------------\n" +
        "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "---------------------------------------------------------\n" +
        "4    3,00    JARRA  CERVEZA                         12,00\n" +
        "1    1,60    COPA DE CERVEZA                         1,60\n" +
        "---------------------------------------------------------\n" +
        "                                  SUB TOTAL :       13,60\n" +
        "                                 TOTAL :      13,60 EUROS\n" +
        "NO: 000018851 IVA INCLUIDO\n" +
        "\n" +
        "---------------------------------------------------------\n" +
        "                             ***GRACIAS POR SU VISITA!***\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "SpanishCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                     BAR RESTAURANT\n" +
        "                            EL POZO\n" +
        "C/.ROCAFORT 187\n" +
        "08029 BARCELONA\n" +
        "NIF :X-3856907Z\n" +
        "TEL :934199465\n" +
        "-----------------------------------\n" +
        "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "-----------------------------------\n" +
        "4 3,00 JARRA  CERVEZA   12,00\n" +
        "1 1,60 COPA DE CERVEZA  1,60\n" +
        "-----------------------------------\n" +
        "                  SUB TOTAL : 13,60\n" +
        "TOTAL:               13,60 EUROS\n" +
        "NO: 000018851 IVA INCLUIDO\n" +
        "\n" +
        "-----------------------------------\n" +
        "         **GRACIAS POR SU VISITA!**\n"
        
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
            encoding = String.Encoding.windowsCP1252
            
            builder.append(SCBCodePageType.CP1252)
        }
        
        builder.append(SCBInternationalType.spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultipleHeight: "BAR RESTAURANT EL POZO\n".data(using: encoding), height: 2)
        
        builder.append((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "------------------------------------------\n" +
            " 4    3,00    JARRA  CERVEZA         12,00\n" +
            " 1    1,60    COPA DE CERVEZA         1,60\n" +
            "------------------------------------------\n" +
            "                     SUB TOTAL :     13,60\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.appendData(withMultipleHeight: "TOTAL:     13,60 EUROS\n".data(using: encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "NO: 000018851  IVA INCLUIDO\n" +
            "------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").data(using: encoding))
        
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
            encoding = String.Encoding.windowsCP1252
            
            builder.append(SCBCodePageType.CP1252)
        }
        
        builder.append(SCBInternationalType.spain)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultipleHeight: "BAR RESTAURANT EL POZO\n".data(using: encoding), height: 2)
        
        builder.append((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "------------------------------------------\n" +
            " 4 3,00 JARRA  CERVEZA               12,00\n" +
            " 1 1,60 COPA DE CERVEZA               1,60\n" +
            "------------------------------------------\n" +
            " SUB TOTAL :                         13,60\n" +
            "                     TOTAL:    13,60 EUROS\n" +
            "NO: 000018851  IVA INCLUIDO\n" +
            "------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append("**** GRACIAS POR SU VISITA! ****\n".data(using: encoding))
    }
}
