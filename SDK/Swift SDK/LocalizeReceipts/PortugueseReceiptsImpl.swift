//
//  PortugueseReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class PortugueseReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "Pt"
        
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
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultipleHeight: (
            "COMERCIAL DE ALIMENTOS\n" +
            "STAR LTDA.\n").data(using: encoding), height: 2)
        
        builder.append((
            "Avenida Moyses Roysen,\n" +
            "S/N Vila Guilherme\n" +
            "Cep: 02049-010 – Sao Paulo – SP\n" +
            "CNPJ: 62.545.579/0013-69\n" +
            "IE:110.819.138.118\n" +
            "IM: 9.041.041-5\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "--------------------------------\n" +
            "MM/DD/YYYY HH:MM:SS\n" +
            "CCF:133939 COO:227808\n" +
            "--------------------------------\n" +
            "CUPOM FISCAL\n" +
            "--------------------------------\n" +
            "001 2505 CAFÉ DO PONTO TRAD A\n" +
            "                    1un F1 8,15)\n" +
            "002 2505 CAFÉ DO PONTO TRAD A\n" +
            "                    1un F1 8,15)\n" +
            "003 2505 CAFÉ DO PONTO TRAD A\n" +
            "                    1un F1 8,15)\n" +
            "004 6129 AGU MIN NESTLE 510ML\n" +
            "                    1un F1 1,39)\n" +
            "005 6129 AGU MIN NESTLE 510ML\n" +
            "                    1un F1 1,39)\n" +
            "--------------------------------\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: "TOTAL  R$  27,23\n".data(using: encoding), width: 2)
        
        builder.append((
            "DINHEIROv                  29,00\n" +
            "TROCO R$                    1,77\n" +
            "Valor dos Tributos R$2,15(7,90%)\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "ITEM(S) CINORADIS 5\n" +
            "OP.:15326  PDV:9  BR,BF:93466\n" +
            "OBRIGADO PERA PREFERENCIA.\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: (
            "VOLTE SEMPRE!\n" +
            "\n").data(using: encoding), width: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "SAC 0800 724 2822\n" +
            "--------------------------------\n" +
            "MD5:\n" +
            "fe028828a532a7dbaf4271155aa4e2db\n" +
            "Calypso_CA CA.20.c13\n" +
            " – Unisys Brasil\n" +
            "--------------------------------\n" +
            "DARUMA AUTOMAÇÃO   MACH 2\n" +
            "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
            "Lj:0204 OPR:ANGELA JORGE\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "DDDDDDDDDAEHFGBFCC\n" +
            "MM/DD/YYYY HH:MM:SS\n" +
            "FAB:DR0911BR000000275026\n" +
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
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultipleHeight: "COMERCIAL DE ALIMENTOS STAR LTDA.\n".data(using: encoding), height: 2)
        
        builder.append((
            "Avenida Moyses Roysen, S/N  Vila Guilherme\n" +
            "Cep: 02049-010 – Sao Paulo – SP\n" +
            "CNPJ: 62.545.579/0013-69\n" +
            "IE:110.819.138.118  IM: 9.041.041-5\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------------\n" +
            "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n" +
            "------------------------------------------------\n" +
            "CUPOM FISCAL\n" +
            "------------------------------------------------\n" +
            "001  2505  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n" +
            "002  2505  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n" +
            "003  2505  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n" +
            "004  6129  AGU MIN NESTLE 510ML  1un F1  1,39)\n" +
            "005  6129  AGU MIN NESTLE 510ML  1un F1  1,39)\n" +
            "------------------------------------------------\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: "TOTAL  R$         27,23\n".data(using: encoding), width: 2)
        
        builder.append((
            "DINHEIROv                                29,00\n" +
            "TROCO R$                                  1,77\n" +
            "Valor dos Tributos R$2,15 (7,90%)\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "ITEM(S) CINORADIS 5\n" +
            "OP.:15326  PDV:9  BR,BF:93466\n" +
            "OBRIGADO PERA PREFERENCIA.\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: (
            "VOLTE SEMPRE!\n" +
            "\n").data(using: encoding), width: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "SAC 0800 724 2822\n" +
            "------------------------------------------------\n" +
            "MD5:fe028828a532a7dbaf4271155aa4e2db\n" +
            "Calypso_CA CA.20.c13 – Unisys Brasil\n" +
            "------------------------------------------------\n" +
            "DARUMA AUTOMAÇÃO   MACH 2\n" +
            "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
            "Lj:0204 OPR:ANGELA JORGE\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "DDDDDDDDDAEHFGBFCC\n" +
            "MM/DD/YYYY HH:MM:SS\n" +
            "FAB:DR0911BR000000275026\n" +
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
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultipleHeight: "COMERCIAL DE ALIMENTOS STAR LTDA.\n".data(using: encoding), height: 2)
        
        builder.append((
            "Avenida Moyses Roysen, S/N  Vila Guilherme\n" +
            "Cep: 02049-010 – Sao Paulo – SP\n" +
            "CNPJ: 62.545.579/0013-69\n" +
            "IE:110.819.138.118  IM: 9.041.041-5\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "---------------------------------------------------------------------\n" +
            "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n" +
            "---------------------------------------------------------------------\n" +
            "CUPOM FISCAL\n" +
            "---------------------------------------------------------------------\n" +
            "001  2505        CAFÉ DO PONTO TRAD A    1un F1            8,15)\n" +
            "002  2505        CAFÉ DO PONTO TRAD A    1un F1            8,15)\n" +
            "003  2505        CAFÉ DO PONTO TRAD A    1un F1            8,15)\n" +
            "004  6129        AGU MIN NESTLE 510ML    1un F1            1,39)\n" +
            "005  6129        AGU MIN NESTLE 510ML    1un F1            1,39)\n" +
            "---------------------------------------------------------------------\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: "TOTAL  R$                  27,23\n".data(using: encoding), width: 2)
        
        builder.append((
            "DINHEIROv                                                  29,00\n" +
            "TROCO R$                                                    1,77\n" +
            "Valor dos Tributos R$2,15 (7,90%)\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "ITEM(S) CINORADIS 5\n" +
            "OP.:15326  PDV:9  BR,BF:93466\n" +
            "OBRIGADO PERA PREFERENCIA.\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: (
            "VOLTE SEMPRE!\n" +
            "\n").data(using: encoding), width: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "SAC 0800 724 2822\n" +
            "---------------------------------------------------------------------\n" +
            "MD5:fe028828a532a7dbaf4271155aa4e2db\n" +
            "Calypso_CA CA.20.c13 – Unisys Brasil\n" +
            "---------------------------------------------------------------------\n" +
            "DARUMA AUTOMAÇÃO   MACH 2\n" +
            "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
            "Lj:0204 OPR:ANGELA JORGE\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "DDDDDDDDDAEHFGBFCC\n" +
            "MM/DD/YYYY HH:MM:SS\n" +
            "FAB:DR0911BR000000275026\n" +
            "\n").data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "COMERCIAL DE ALIMENTOS\n" +
        "         STAR LTDA.\n" +
        "Avenida Moyses Roysen,\n" +
        "S/N Vila Guilherme\n" +
        "Cep: 02049-010 – Sao Paulo\n" +
        "     – SP\n" +
        "CNPJ: 62.545.579/0013-69\n" +
        "IE:110.819.138.118\n" +
        "IM: 9.041.041-5\n" +
        "--------------------------\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "CCF:133939 COO:227808\n" +
        "--------------------------\n" +
        "CUPOM FISCAL\n" +
        "--------------------------\n" +
        "01 CAFÉ DO PONTO TRAD A\n" +
        "              1un F1 8,15)\n" +
        "02 CAFÉ DO PONTO TRAD A\n" +
        "              1un F1 8,15)\n" +
        "03 CAFÉ DO PONTO TRAD A\n" +
        "              1un F1 8,15)\n" +
        "04 AGU MIN NESTLE 510ML\n" +
        "              1un F1 1,39)\n" +
        "05 AGU MIN NESTLE 510ML\n" +
        "              1un F1 1,39)\n" +
        "--------------------------\n" +
        "TOTAL  R$            27,23\n" +
        "DINHEIROv            29,00\n" +
        "\n" +
        "TROCO R$              1,77\n" +
        "Valor dos Tributos\n" +
        "R$2,15(7,90%)\n" +
        "ITEM(S) CINORADIS 5\n" +
        "OP.:15326  PDV:9\n" +
        "            BR,BF:93466\n" +
        "OBRIGADO PERA PREFERENCIA.\n" +
        "VOLTE SEMPRE!\n" +
        "SAC 0800 724 2822\n" +
        "--------------------------\n" +
        "MD5:\n" +
        "fe028828a532a7dbaf4271155a\n" +
        "a4e2db\n" +
        "Calypso_CA CA.20.c13\n" +
        " – Unisys Brasil\n" +
        "--------------------------\n" +
        "DARUMA AUTOMAÇÃO   MACH 2\n" +
        "ECF-IF VERSÃO:01,00,00\n" +
        "ECF:093\n" +
        "Lj:0204 OPR:ANGELA JORGE\n" +
        "DDDDDDDDDAEHFGBFCC\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "FAB:DR0911BR000000275026\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "         COMERCIAL DE ALIMENTOS\n" +
        "              STAR LTDA.\n" +
        "        Avenida Moyses Roysen,\n" +
        "          S/N Vila Guilherme\n" +
        "     Cep: 02049-010 – Sao Paulo – SP\n" +
        "        CNPJ: 62.545.579/0013-69\n" +
        "  IE:110.819.138.118    IM: 9.041.041-5\n" +
        "---------------------------------------\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "CCF:133939   COO:227808\n" +
        "---------------------------------------\n" +
        "CUPOM FISCAL\n" +
        "---------------------------------------\n" +
        "01  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n" +
        "02  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n" +
        "03  CAFÉ DO PONTO TRAD A  1un F1  8,15)\n" +
        "04  AGU MIN NESTLE 510ML  1un F1  1,39)\n" +
        "05  AGU MIN NESTLE 510ML  1un F1  1,39)\n" +
        "---------------------------------------\n" +
        "TOTAL  R$                         27,23\n" +
        "DINHEIROv                         29,00\n" +
        "\n" +
        "TROCO R$                           1,77\n" +
        "Valor dos Tributos R$2,15(7,90%)\n" +
        "ITEM(S) CINORADIS 5\n" +
        "OP.:15326  PDV:9  BR,BF:93466\n" +
        "OBRIGADO PERA PREFERENCIA.\n" +
        "VOLTE SEMPRE!    SAC 0800 724 2822\n" +
        "---------------------------------------\n" +
        "MD5:  fe028828a532a7dbaf4271155aa4e2db\n" +
        "Calypso_CA CA.20.c13 – Unisys Brasil\n" +
        "---------------------------------------\n" +
        "DARUMA AUTOMAÇÃO   MACH 2\n" +
        "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
        "Lj:0204 OPR:ANGELA JORGE\n" +
        "DDDDDDDDDAEHFGBFCC\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "FAB:DR0911BR000000275026\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "            COMERCIAL DE ALIMENTOS STAR LTDA.\n" +
        "         Avenida Moyses Roysen, S/N Vila Guilherme\n" +
        "              Cep: 02049-010 – Sao Paulo – SP\n" +
        "                  CNPJ: 62.545.579/0013-69\n" +
        "                    IE:110.819.138.118    IM: 9.041.041-5\n" +
        "---------------------------------------------------------\n" +
        "              MM/DD/YYYY HH:MM:SS CCF:133939   COO:227808\n" +
        "---------------------------------------------------------\n" +
        "CUPOM FISCAL\n" +
        "---------------------------------------------------------\n" +
        "01   CAFÉ DO PONTO TRAD A    1un F1                 8,15)\n" +
        "02   CAFÉ DO PONTO TRAD A    1un F1                 8,15)\n" +
        "03   CAFÉ DO PONTO TRAD A    1un F1                 8,15)\n" +
        "04   AGU MIN NESTLE 510ML    1un F1                 1,39)\n" +
        "05   AGU MIN NESTLE 510ML    1un F1                 1,39)\n" +
        "---------------------------------------------------------\n" +
        "TOTAL  R$                                           27,23\n" +
        "DINHEIROv                                           29,00\n" +
        "\n" +
        "TROCO R$                                             1,77\n" +
        "Valor dos Tributos R$2,15(7,90%)\n" +
        "ITEM(S) CINORADIS 5\n" +
        "OP.:15326  PDV:9  BR,BF:93466\n" +
        "OBRIGADO PERA PREFERENCIA.\n" +
        "                       VOLTE SEMPRE!    SAC 0800 724 2822\n" +
        "---------------------------------------------------------\n" +
        "                   MD5:  fe028828a532a7dbaf4271155aa4e2db\n" +
        "                     Calypso_CA CA.20.c13 – Unisys Brasil\n" +
        "---------------------------------------------------------\n" +
        "DARUMA AUTOMAÇÃO   MACH 2\n" +
        "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
        "Lj:0204 OPR:ANGELA JORGE\n" +
        "DDDDDDDDDAEHFGBFCC\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "FAB:DR0911BR000000275026\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "PortugueseCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "     COMERCIAL DE ALIMENTOS\n" +
        "            STAR LTDA.\n" +
        "      Avenida Moyses Roysen,\n" +
        "        S/N Vila Guilherme\n" +
        "  Cep: 02049-010 – Sao Paulo – SP\n" +
        "      CNPJ: 62.545.579/0013-69\n" +
        "IE:110.819.138.118  IM: 9.041.041-5\n" +
        "-----------------------------------\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "CCF:133939   COO:227808\n" +
        "-----------------------------------\n" +
        "CUPOM FISCAL\n" +
        "-----------------------------------\n" +
        "01  CAFÉ DO PONTO TRAD A\n" +
        "                      1un F1  8,15)\n" +
        "02  CAFÉ DO PONTO TRAD A\n" +
        "                      1un F1  8,15)\n" +
        "03  CAFÉ DO PONTO TRAD A\n" +
        "                      1un F1  8,15)\n" +
        "04  AGU MIN NESTLE 510ML\n" +
        "                      1un F1  1,39)\n" +
        "05  AGU MIN NESTLE 510ML\n" +
        "                      1un F1  1,39)\n" +
        "-----------------------------------\n" +
        "TOTAL  R$                     27,23\n" +
        "DINHEIROv                     29,00\n" +
        "\n" +
        "TROCO R$                       1,77\n" +
        "Valor dos Tributos R$2,15(7,90%)\n" +
        "ITEM(S) CINORADIS 5\n" +
        "OP.:15326  PDV:9  BR,BF:93466\n" +
        "OBRIGADO PERA PREFERENCIA.\n" +
        "VOLTE SEMPRE!     SAC 0800 724 2822\n" +
        "-----------------------------------\n" +
        "MD5:\n" +
        "fe028828a532a7dbaf4271155aa4e2db\n" +
        "Calypso_CA CA.20.c13\n" +
        " – Unisys Brasil\n" +
        "-----------------------------------\n" +
        "DARUMA AUTOMAÇÃO   MACH 2\n" +
        "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
        "Lj:0204 OPR:ANGELA JORGE\n" +
        "DDDDDDDDDAEHFGBFCC\n" +
        "MM/DD/YYYY HH:MM:SS\n" +
        "FAB:DR0911BR000000275026\n"
        
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
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultipleHeight: "COMERCIAL DE ALIMENTOS STAR LTDA.\n".data(using: encoding), height: 2)
        
        builder.append((
            "Avenida Moyses Roysen, S/N  Vila Guilherme\n" +
            "Cep: 02049-010 – Sao Paulo – SP\n" +
            "CNPJ: 62.545.579/0013-69\n" +
            "IE:110.819.138.118  IM: 9.041.041-5\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------\n" +
            "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n" +
            "------------------------------------------\n" +
            "CUPOM FISCAL\n" +
            "------------------------------------------\n" +
            "001   2505    CAFÉ DO PONTO TRAD A\n" +
            "                            1un F1  8,15)\n" +
            "002   2505    CAFÉ DO PONTO TRAD A\n" +
            "                            1un F1  8,15)\n" +
            "003   2505    CAFÉ DO PONTO TRAD A\n" +
            "                            1un F1  8,15)\n" +
            "004   6129    AGU MIN NESTLE 510ML\n" +
            "                            1un F1  1,39)\n" +
            "005   6129    AGU MIN NESTLE 510ML\n" +
            "                            1un F1  1,39)\n" +
            "------------------------------------------\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: "TOTAL  R$      27,23\n".data(using: encoding), width: 2)
        
        builder.append((
            "DINHEIROv                          29,00\n" +
            "TROCO R$                            1,77\n" +
            "Valor dos Tributos R$2,15 (7,90%)\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "ITEM(S) CINORADIS 5\n" +
            "OP.:15326  PDV:9  BR,BF:93466\n" +
            "OBRIGADO PERA PREFERENCIA.\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: (
            "VOLTE SEMPRE!\n" +
            "\n").data(using: encoding), width: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "SAC 0800 724 2822\n" +
            "------------------------------------------\n" +
            "MD5:fe028828a532a7dbaf4271155aa4e2db\n" +
            "Calypso_CA CA.20.c13 – Unisys Brasil\n" +
            "------------------------------------------\n" +
            "DARUMA AUTOMAÇÃO   MACH 2\n" +
            "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
            "Lj:0204 OPR:ANGELA JORGE\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "DDDDDDDDDAEHFGBFCC\n" +
            "MM/DD/YYYY HH:MM:SS\n" +
            "FAB:DR0911BR000000275026\n" +
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
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
//      builder.append("[If loaded.. Logo1 goes here]\n".data(using: encoding))
//
//      builder.appendLogo(SCBLogoSize.normal, number: 1)
        
        builder.appendData(withMultipleHeight: "\nCOMERCIAL DE ALIMENTOS STAR LTDA.\n".data(using: encoding), height: 2)
        
        builder.append((
            "Avenida Moyses Roysen, S/N  Vila Guilherme\n" +
            "Cep: 02049-010 – Sao Paulo – SP\n" +
            "CNPJ: 62.545.579/0013-69\n" +
            "IE:110.819.138.118  IM: 9.041.041-5\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "------------------------------------------\n" +
            "MM/DD/YYYY HH:MM:SS  CCF:133939 COO:227808\n" +
            "------------------------------------------\n" +
            "CUPOM FISCAL\n" +
            "------------------------------------------\n" +
            "01 2505 CAFÉ DO PONTO TRAD A  1un F1 8,15)\n" +
            "02 2505 CAFÉ DO PONTO TRAD A  1un F1 8,15)\n" +
            "03 2505 CAFÉ DO PONTO TRAD A  1un F1 8,15)\n" +
            "04 6129 AGU MIN NESTLE 510ML  1un F1 1,39)\n" +
            "05 6129 AGU MIN NESTLE 510ML  1un F1 1,39)\n" +
            "------------------------------------------\n" +
            "TOTAL  R$                            27,23\n" +
            "DINHEIROv                            29,00\n" +
            "TROCO R$                              1,77\n" +
            "Valor dos Tributos R$2,15 (7,90%)\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "ITEM(S) CINORADIS 5\n" +
            "OP.:15326  PDV:9  BR,BF:93466\n" +
            "OBRIGADO PERA PREFERENCIA.\n").data(using: encoding))
        
        builder.appendData(withMultipleWidth: (
            "VOLTE SEMPRE!\n" +
            "\n").data(using: encoding), width: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "SAC 0800 724 2822\n" +
            "------------------------------------------\n" +
            "MD5:  fe028828a532a7dbaf4271155aa4e2db\n" +
            "Calypso_CA CA.20.c13 – Unisys Brasil\n" +
            "------------------------------------------\n" +
            "DARUMA AUTOMAÇÃO   MACH 2\n" +
            "ECF-IF VERSÃO:01,00,00 ECF:093\n" +
            "Lj:0204 OPR:ANGELA JORGE\n" +
            "\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "DDDDDDDDDAEHFGBFCC\n" +
            "MM/DD/YYYY HH:MM:SS\n" +
            "FAB:DR0911BR000000275026\n").data(using: encoding))
    }
}
