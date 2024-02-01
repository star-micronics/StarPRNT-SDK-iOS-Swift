//
//  RussianReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class RussianReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "Ru"
        
        characterCode = StarIoExtCharacterCode.standard
    }
    
    override func append2inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.windowsCP1251
            
            builder.append(SCBCodePageType.CP1251)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultiple: "Р Е Л А К С\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "ООО “РЕЛАКС”\n" +
                "СПб., Малая Балканская, д. 38, лит. А\n" +
            "тел. 307-07-12\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "РЕГ №322736     ИНН:123321\n" +
            "01 Белякова И.А.КАССА: 0020 ОТД.01\n").data(using: encoding))
        
        builder.appendData(withAlignment: "ЧЕК НА ПРОДАЖУ  No 84373\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "--------------------------------\n" +
            " 1. Яблоки Айдаред, кг    144.50\n" +
            " 2. Соус соевый Sen So     36.40\n" +
            " 3. Соус томатный Клас     19.90\n" +
            " 4. Ребра свиные в.к м     78.20\n" +
            " 5. Масло подсол раф д    114.00\n" +
            " 6. Блокнот 10х14см сп    164.00\n" +
            " 7. Морс Северная Ягод     99.90\n" +
            " 8. Активия Биойогурт      43.40\n" +
            " 9. Бублики Украинские     26.90\n" +
            "10. Активия Биойогурт      43.40\n" +
            "11. Сахар-песок 1кг        58.40\n" +
            "12. Хлопья овсяные Ясн     38.40\n" +
            "13. Кинза 50г              39.90\n" +
            "14. Пемза “Сердечко” .Т    37.90\n" +
            "15. Приправа Santa Mar     47.90\n" +
            "16. Томаты слива Выбор    162.00\n" +
            "17. Бонд Стрит Ред Сел     56.90\n" +
            "--------------------------------\n" +
            "--------------------------------\n" +
            "ДИСКОНТНАЯ КАРТА\n" +
            "                No:2440012489765\n" +
            "--------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.append((
            "ИТОГО К ОПЛАТЕ = 1212.00\n" +
            "НАЛИЧНЫЕ = 1212.00\n" +
            "ВАША СКИДКА : 0.41\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: (
            "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
            "\n").data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "08-02-2015 09:49  0254.0130604\n" +
            "00083213 #060127\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "СПАСИБО ЗА ПОКУПКУ !\n" +
            "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
            "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n" +
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
            encoding = String.Encoding.windowsCP1251
            
            builder.append(SCBCodePageType.CP1251)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultiple: "Р Е Л А К С\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "ООО “РЕЛАКС”\n" +
            "СПб., Малая Балканская, д. 38, лит. А\n" +
            "тел. 307-07-12\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "РЕГ №322736 ИНН : 123321\n" +
            "01  Белякова И.А.  КАССА: 0020 ОТД.01\n").data(using: encoding))
        
        builder.appendData(withAlignment: "ЧЕК НА ПРОДАЖУ  No 84373\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "------------------------------------------------\n" +
            "1.     Яблоки Айдаред, кг                 144.50\n" +
            "2.     Соус соевый Sen So                  36.40\n" +
            "3.     Соус томатный Клас                  19.90\n" +
            "4.     Ребра свиные в.к м                  78.20\n" +
            "5.     Масло подсол раф д                 114.00\n" +
            "6.     Блокнот 10х14см сп                 164.00\n" +
            "7.     Морс Северная Ягод                  99.90\n" +
            "8.     Активия Биойогурт                   43.40\n" +
            "9.     Бублики Украинские                  26.90\n" +
            "10.    Активия Биойогурт                   43.40\n" +
            "11.    Сахар-песок 1кг                     58.40\n" +
            "12.    Хлопья овсяные Ясн                  38.40\n" +
            "13.    Кинза 50г                           39.90\n" +
            "14.    Пемза “Сердечко” .Т                 37.90\n" +
            "15.    Приправа Santa Mar                  47.90\n" +
            "16.    Томаты слива Выбор                 162.00\n" +
            "17.    Бонд Стрит Ред Сел                  56.90\n" +
            "------------------------------------------------\n" +
            "------------------------------------------------\n" +
            "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n" +
            "------------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.append((
            "ИТОГО  К  ОПЛАТЕ     = 1212.00\n" +
            "НАЛИЧНЫЕ             = 1212.00\n" +
            "ВАША СКИДКА : 0.41\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: (
            "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
            "\n").data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "08-02-2015 09:49  0254.0130604\n" +
            "00083213 #060127\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "СПАСИБО ЗА ПОКУПКУ !\n" +
            "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
            "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n" +
            "\n").data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology:SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology:SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func append4inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.windowsCP1251
            
            builder.append(SCBCodePageType.CP1251)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultiple: "Р Е Л А К С\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "ООО “РЕЛАКС”\n" +
            "СПб., Малая Балканская, д. 38, лит. А\n" +
            "тел. 307-07-12\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "РЕГ №322736 ИНН : 123321\n" +
            "01  Белякова И.А.  КАССА: 0020 ОТД.01\n").data(using: encoding))
        
        builder.appendData(withAlignment: "ЧЕК НА ПРОДАЖУ  No 84373\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "---------------------------------------------------------------------\n" +
            "1.     Яблоки Айдаред, кг                                      144.50\n" +
            "2.     Соус соевый Sen So                                       36.40\n" +
            "3.     Соус томатный Клас                                       19.90\n" +
            "4.     Ребра свиные в.к м                                       78.20\n" +
            "5.     Масло подсол раф д                                      114.00\n" +
            "6.     Блокнот 10х14см сп                                      164.00\n" +
            "7.     Морс Северная Ягод                                       99.90\n" +
            "8.     Активия Биойогурт                                        43.40\n" +
            "9.     Бублики Украинские                                       26.90\n" +
            "10.    Активия Биойогурт                                        43.40\n" +
            "11.    Сахар-песок 1кг                                          58.40\n" +
            "12.    Хлопья овсяные Ясн                                       38.40\n" +
            "13.    Кинза 50г                                                39.90\n" +
            "14.    Пемза “Сердечко” .Т                                      37.90\n" +
            "15.    Приправа Santa Mar                                       47.90\n" +
            "16.    Томаты слива Выбор                                      162.00\n" +
            "17.    Бонд Стрит Ред Сел                                       56.90\n" +
            "---------------------------------------------------------------------\n" +
            "---------------------------------------------------------------------\n" +
            "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n" +
            "---------------------------------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.append((
            "ИТОГО  К  ОПЛАТЕ           = 1212.00\n" +
            "НАЛИЧНЫЕ                   = 1212.00\n" +
            "ВАША СКИДКА : 0.41\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: (
            "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
            "\n").data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "08-02-2015 09:49  0254.0130604\n" +
            "00083213 #060127\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "СПАСИБО ЗА ПОКУПКУ !\n" +
            "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
            "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n" +
            "\n").data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "          Р Е Л А К С\n" +
        "          ООО “РЕЛАКС”\n" +
        "СПб., Малая Балканская, д.\n" +
        "38, лит. А\n" +
        "\n" +
        "тел. 307-07-12\n" +
        "РЕГ №322736     ИНН:123321\n" +
        "01 Белякова И.А. КАССА:0020\n" +
        "ОТД.01\n" +
        "ЧЕК НА ПРОДАЖУ  No 84373\n" +
        "----------------------------\n" +
        " 1.Яблоки Айдаред, кг 144.50\n" +
        " 2.Соус соевый Sen So  36.40\n" +
        " 3.Соус томатный Клас  19.90\n" +
        " 4.Ребра свиные в.к м  78.20\n" +
        " 5.Масло подсол раф д 114.00\n" +
        " 6.Блокнот 10х14см сп 164.00\n" +
        " 7.Морс Северная Ягод  99.90\n" +
        " 8.Активия Биойогурт   43.40\n" +
        " 9.Бублики Украинские  26.90\n" +
        "10.Активия Биойогурт   43.40\n" +
        "11.Сахар-песок 1кг     58.40\n" +
        "12.Хлопья овсяные Ясн  38.40\n" +
        "13.Кинза 50г           39.90\n" +
        "14.Пемза “Сердечко” .Т 37.90\n" +
        "15.Приправа Santa Mar  47.90\n" +
        "16.Томаты слива Выбор 162.00\n" +
        "17.Бонд Стрит Ред Сел  56.90\n" +
        "----------------------------\n" +
        "----------------------------\n" +
        "ДИСКОНТНАЯ КАРТА\n" +
        "            No:2440012489765\n" +
        "----------------------------\n" +
        "ИТОГО К ОПЛАТЕ = 1212.00\n" +
        "НАЛИЧНЫЕ = 1212.00\n" +
        "ВАША СКИДКА : 0.41\n" +
        "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
        "\n" +
        "08-02-2015 09:49\n" +
        "0254.013060400083213 #060127\n" +
        "СПАСИБО ЗА ПОКУПКУ !\n" +
        "\n" +
        "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО\n" +
        "23 СОХРАНЯЙТЕ, ПОЖАЛУЙСТА ,\n" +
        "ЧЕК\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 11 * 2)!
//      let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "      Р Е Л А К С   ООО “РЕЛАКС”\n" +
        " СПб., Малая Балканская, д. 38, лит. А\n" +
        "\n" +
        "тел. 307-07-12\n" +
        "РЕГ №322736     ИНН:123321\n" +
        "01 Белякова И.А. КАССА: 0020 ОТД.01\n" +
        "ЧЕК НА ПРОДАЖУ  No 84373\n" +
        "--------------------------------------\n" +
        " 1. Яблоки Айдаред, кг          144.50\n" +
        " 2. Соус соевый Sen So           36.40\n" +
        " 3. Соус томатный Клас           19.90\n" +
        " 4. Ребра свиные в.к м           78.20\n" +
        " 5. Масло подсол раф д          114.00\n" +
        " 6. Блокнот 10х14см сп          164.00\n" +
        " 7. Морс Северная Ягод           99.90\n" +
        " 8. Активия Биойогурт            43.40\n" +
        " 9. Бублики Украинские           26.90\n" +
        "10. Активия Биойогурт            43.40\n" +
        "11. Сахар-песок 1кг              58.40\n" +
        "12. Хлопья овсяные Ясн           38.40\n" +
        "13. Кинза 50г                    39.90\n" +
        "14. Пемза “Сердечко” .Т          37.90\n" +
        "15. Приправа Santa Mar           47.90\n" +
        "16. Томаты слива Выбор          162.00\n" +
        "17. Бонд Стрит Ред Сел           56.90\n" +
        "--------------------------------------\n" +
        "--------------------------------------\n" +
        "ДИСКОНТНАЯ КАРТА      No:2440012489765\n" +
        "--------------------------------------\n" +
        "ИТОГО К ОПЛАТЕ = 1212.00\n" +
        "НАЛИЧНЫЕ = 1212.00\n" +
        "ВАША СКИДКА : 0.41\n" +
        "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
        "\n" +
        "08-02-2015 09:49  0254.0130604\n" +
        "00083213 #060127\n" +
        "               СПАСИБО ЗА ПОКУПКУ !\n" +
        "\n" +
        "    МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
        "        СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "               Р Е Л А К С   ООО “РЕЛАКС”\n" +
        "                СПб., Малая Балканская, д. 38, лит. А\n" +
        "\n" +
        "тел. 307-07-12\n" +
        "РЕГ №322736     ИНН:123321\n" +
        "01 Белякова И.А. КАССА: 0020 ОТД.01\n" +
        "ЧЕК НА ПРОДАЖУ  No 84373\n" +
        "-----------------------------------------------------\n" +
        " 1.      Яблоки Айдаред, кг                    144.50\n" +
        " 2.      Соус соевый Sen So                     36.40\n" +
        " 3.      Соус томатный Клас                     19.90\n" +
        " 4.      Ребра свиные в.к м                     78.20\n" +
        " 5.      Масло подсол раф д                    114.00\n" +
        " 6.      Блокнот 10х14см сп                    164.00\n" +
        " 7.      Морс Северная Ягод                     99.90\n" +
        " 8.      Активия Биойогурт                      43.40\n" +
        " 9.      Бублики Украинские                     26.90\n" +
        "10.      Активия Биойогурт                      43.40\n" +
        "11.      Сахар-песок 1кг                        58.40\n" +
        "12.      Хлопья овсяные Ясн                     38.40\n" +
        "13.      Кинза 50г                              39.90\n" +
        "14.      Пемза “Сердечко” .Т                    37.90\n" +
        "15.      Приправа Santa Mar                     47.90\n" +
        "16.      Томаты слива Выбор                    162.00\n" +
        "17.      Бонд Стрит Ред Сел                     56.90\n" +
        "-----------------------------------------------------\n" +
        "-----------------------------------------------------\n" +
        "ДИСКОНТНАЯ КАРТА                     No:2440012489765\n" +
        "-----------------------------------------------------\n" +
        "ИТОГО К ОПЛАТЕ = 1212.00\n" +
        "НАЛИЧНЫЕ = 1212.00\n" +
        "ВАША СКИДКА : 0.41\n" +
        "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
        "\n" +
        "08-02-2015 09:49  0254.0130604\n" +
        "00083213 #060127\n" +
        "                                 СПАСИБО ЗА ПОКУПКУ !\n" +
        "\n" +
        "                      МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
        "                         СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "RussianCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "   Р Е Л А К С    ООО “РЕЛАКС”\n" +
        "    СПб., Малая Балканская, д.\n" +
        "           38, лит. А\n" +
        "\n" +
        "тел. 307-07-12\n" +
        "РЕГ №322736     ИНН:123321\n" +
        "01 Белякова И.А. КАССА: 0020 ОТД.01\n" +
        "ЧЕК НА ПРОДАЖУ  No 84373\n" +
        "-----------------------------------\n" +
        " 1. Яблоки Айдаред, кг       144.50\n" +
        " 2. Соус соевый Sen So        36.40\n" +
        " 3. Соус томатный Клас        19.90\n" +
        " 4. Ребра свиные в.к м        78.20\n" +
        " 5. Масло подсол раф д       114.00\n" +
        " 6. Блокнот 10х14см сп       164.00\n" +
        " 7. Морс Северная Ягод        99.90\n" +
        " 8. Активия Биойогурт         43.40\n" +
        " 9. Бублики Украинские        26.90\n" +
        "10. Активия Биойогурт         43.40\n" +
        "11. Сахар-песок 1кг           58.40\n" +
        "12. Хлопья овсяные Ясн        38.40\n" +
        "13. Кинза 50г                 39.90\n" +
        "14. Пемза “Сердечко” .Т       37.90\n" +
        "15. Приправа Santa Mar        47.90\n" +
        "16. Томаты слива Выбор       162.00\n" +
        "17. Бонд Стрит Ред Сел        56.90\n" +
        "-----------------------------------\n" +
        "-----------------------------------\n" +
        "ДИСКОНТНАЯ КАРТА   No:2440012489765\n" +
        "-----------------------------------\n" +
        "ИТОГО К ОПЛАТЕ = 1212.00\n" +
        "НАЛИЧНЫЕ = 1212.00\n" +
        "ВАША СКИДКА : 0.41\n" +
        "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
        "\n" +
        "08-02-2015 09:49  0254.0130604\n" +
        "00083213 #060127\n" +
        "               СПАСИБО ЗА ПОКУПКУ !\n" +
        "\n" +
        "    МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
        "       СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n"
        
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
            encoding = String.Encoding.windowsCP1251
            
            builder.append(SCBCodePageType.CP1251)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultiple: "Р Е Л А К С\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "ООО “РЕЛАКС”\n" +
            "СПб., Малая Балканская, д. 38, лит. А\n" +
            "тел. 307-07-12\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "РЕГ №322736 ИНН : 123321\n" +
            "01  Белякова И.А.  КАССА: 0020 ОТД.01\n").data(using: encoding))
        
        builder.appendData(withAlignment: "ЧЕК НА ПРОДАЖУ  No 84373\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "------------------------------------------\n" +
            "1.     Яблоки Айдаред, кг           144.50\n" +
            "2.     Соус соевый Sen So            36.40\n" +
            "3.     Соус томатный Клас            19.90\n" +
            "4.     Ребра свиные в.к м            78.20\n" +
            "5.     Масло подсол раф д           114.00\n" +
            "6.     Блокнот 10х14см сп           164.00\n" +
            "7.     Морс Северная Ягод            99.90\n" +
            "8.     Активия Биойогурт             43.40\n" +
            "9.     Бублики Украинские            26.90\n" +
            "10.    Активия Биойогурт             43.40\n" +
            "11.    Сахар-песок 1кг               58.40\n" +
            "12.    Хлопья овсяные Ясн            38.40\n" +
            "13.    Кинза 50г                     39.90\n" +
            "14.    Пемза “Сердечко” .Т           37.90\n" +
            "15.    Приправа Santa Mar            47.90\n" +
            "16.    Томаты слива Выбор           162.00\n" +
            "17.    Бонд Стрит Ред Сел            56.90\n" +
            "------------------------------------------\n" +
            "------------------------------------------\n" +
            "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n" +
            "------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.append((
            "ИТОГО  К  ОПЛАТЕ     = 1212.00\n" +
            "НАЛИЧНЫЕ             = 1212.00\n" +
            "ВАША СКИДКА : 0.41\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: (
            "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
            "\n").data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "08-02-2015 09:49  0254.0130604\n" +
            "00083213 #060127\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "СПАСИБО ЗА ПОКУПКУ !\n" +
            "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
            "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n" +
            "\n").data(using: encoding))
        
//      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology:SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology:SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
    }
    
    override func appendDotImpact3inchTextReceiptData(_ builder: ISCBBuilder, utf8: Bool) {
        let encoding: String.Encoding
        
        if utf8 == true {
            encoding = String.Encoding.utf8
            
            builder.append(SCBCodePageType.UTF8)
        }
        else {
            encoding = String.Encoding.windowsCP1251
            
            builder.append(SCBCodePageType.CP1251)
        }
        
//      builder.appendInternational(SCBInternationalType.UK)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.appendData(withMultiple: "Р  Е  Л  А  К  С\n".data(using: encoding), width: 2, height: 2)
        
        builder.append((
            "ООО “РЕЛАКС”\n" +
            "СПб., Малая Балканская, д. 38, лит. А\n" +
            "тел. 307-07-12\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.left)
        
        builder.append((
            "РЕГ №322736 ИНН : 123321\n" +
            "01  Белякова И.А.  КАССА: 0020 ОТД.01\n").data(using: encoding))
        
        builder.appendData(withAlignment: "ЧЕК НА ПРОДАЖУ  No 84373\n".data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "------------------------------------------\n" +
            "1.     Яблоки Айдаред, кг           144.50\n" +
            "2.     Соус соевый Sen So            36.40\n" +
            "3.     Соус томатный Клас            19.90\n" +
            "4.     Ребра свиные в.к м            78.20\n" +
            "5.     Масло подсол раф д           114.00\n" +
            "6.     Блокнот 10х14см сп           164.00\n" +
            "7.     Морс Северная Ягод            99.90\n" +
            "8.     Активия Биойогурт             43.40\n" +
            "9.     Бублики Украинские            26.90\n" +
            "10.    Активия Биойогурт             43.40\n" +
            "11.    Сахар-песок 1кг               58.40\n" +
            "12.    Хлопья овсяные Ясн            38.40\n" +
            "13.    Кинза 50г                     39.90\n" +
            "14.    Пемза “Сердечко” .Т           37.90\n" +
            "15.    Приправа Santa Mar            47.90\n" +
            "16.    Томаты слива Выбор           162.00\n" +
            "17.    Бонд Стрит Ред Сел            56.90\n" +
            "------------------------------------------\n" +
            "------------------------------------------\n" +
            "ДИСКОНТНАЯ КАРТА  No: 2440012489765\n" +
            "------------------------------------------\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.right)
        
        builder.append((
            "ИТОГО  К  ОПЛАТЕ  = 1212.00\n" +
            "НАЛИЧНЫЕ          = 1212.00\n" +
            "ВАША СКИДКА : 0.41\n" +
            "\n").data(using: encoding))
        
        builder.appendData(withAlignment: (
            "ЦЕНЫ УКАЗАНЫ С УЧЕТОМ СКИДКИ\n" +
            "\n").data(using: encoding), position: SCBAlignmentPosition.center)
        
        builder.append((
            "08-02-2015 09:49  0254.0130604\n" +
            "00083213 #060127\n").data(using: encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        
        builder.append((
            "СПАСИБО ЗА ПОКУПКУ !\n" +
            "МЫ  ОТКРЫТЫ ЕЖЕДНЕВНО С 9 ДО 23\n" +
            "СОХРАНЯЙТЕ, ПОЖАЛУЙСТА , ЧЕК\n").data(using: encoding))
    }
}
