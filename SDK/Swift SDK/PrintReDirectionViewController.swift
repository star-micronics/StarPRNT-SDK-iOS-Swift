//
//  PrintReDirectionViewController.swift
//  Swift SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

import Foundation

class PrintReDirectionViewController: PrinterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "Print Re-Direction"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            if indexPath.section == 0 {
                if AppDelegate.settingManager.settings[1] == nil {
                    let cellIdentifier: String = "UITableViewCellStyleValue1"
                    
                    cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
                    
                    if cell == nil {
                        cell = UITableViewCell(style: UITableViewCell.CellStyle.value1,
                                               reuseIdentifier: cellIdentifier)
                    }
                    
                    if cell != nil {
                        cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                        
                        cell.textLabel!.text = "Unselected State"
                        cell.detailTextLabel!.text = ""
                        
                        cell.textLabel!.textColor = UIColor.red
                        cell.detailTextLabel!.textColor = UIColor.red
                        
                        UIView.beginAnimations(nil, context: nil)
                        
                        cell.textLabel!.alpha = 0.0
                        cell.detailTextLabel!.alpha = 0.0
                        
                        UIView.setAnimationDelay             (0.0)                             // 0mS!!!
                        UIView.setAnimationDuration          (0.6)                             // 600mS!!!
                        UIView.setAnimationRepeatCount       (Float(UINT32_MAX))
                        UIView.setAnimationRepeatAutoreverses(true)
                        UIView.setAnimationCurve             (UIView.AnimationCurve.easeIn)
                        
                        cell.textLabel!.alpha = 1.0
                        cell.detailTextLabel!.alpha = 1.0
                        
                        UIView.commitAnimations()
                        
                        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                        
                        cell.isUserInteractionEnabled = true
                    }
                }
                else {
                    let currentSetting = AppDelegate.settingManager.settings[1]!
                    
                    let cellIdentifier: String = "UITableViewCellStyleSubtitle"
                    
                    cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
                    
                    if cell == nil {
                        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                               reuseIdentifier: cellIdentifier)
                    }
                    
                    cell.textLabel!.text = currentSetting.modelName
                    
                    if currentSetting.macAddress == "" {
                        cell.detailTextLabel!.text = currentSetting.portName
                    } else {
                        cell.detailTextLabel!.text = "\(currentSetting.portName) (\(currentSetting.macAddress))"
                    }
                    
                    cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                    cell.textLabel!.textColor = UIColor.blue
                    cell.detailTextLabel!.textColor = UIColor.blue
                    cell.accessoryType = .disclosureIndicator
                    
                    return cell
                }
            } else if indexPath.section == 1 {
                let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(),
                                                                                                  paperSizeIndex: AppDelegate.getSelectedPaperSize())
                
                if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
                    switch indexPath.row {
                    case 0:
                        cell.textLabel!.text = String(format: "%@ %@ Text Receipt",
                                                      localizeReceipts.languageCode,
                                                      localizeReceipts.paperSize)
                    case 1:
                        cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",
                                                      localizeReceipts.languageCode,
                                                      localizeReceipts.paperSize)
                    case 2:
                        cell.textLabel!.text = String(format: "%@ %@ Raster Receipt",
                                                      localizeReceipts.languageCode,
                                                      localizeReceipts.paperSize)
                    case 3:
                        cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Both Scale)",
                                                      localizeReceipts.languageCode,
                                                      localizeReceipts.scalePaperSize)
                    case 4:
                        cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Scale)",
                                                      localizeReceipts.languageCode,
                                                      localizeReceipts.scalePaperSize)
                    case 5 :
                        cell.textLabel!.text = String(format: "%@ Raster Coupon",
                                                      localizeReceipts.languageCode)
                    case 6  :
                        cell.textLabel!.text = String(format: "%@ Raster Coupon (Rotation90)",
                                                      localizeReceipts.languageCode)
                    default :
                        fatalError()
                    }
                }
                else {
                    cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",
                                                  localizeReceipts.languageCode,
                                                  localizeReceipts.paperSize)
                }
                
                cell.detailTextLabel!.text = ""
                
                cell.textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                
                var userInteractionEnabled: Bool = true
                
                guard let modelIndex = AppDelegate.getSelectedModelIndex() else {
                    fatalError()
                }
                
                guard let printerInfo = ModelCapability.modelCapabilityDictionary[modelIndex] else {
                    fatalError()
                }
                
                if indexPath.row == 0 ||     // Text Receipt
                    indexPath.row == 1 {      // Text Receipt (UTF8)
                    userInteractionEnabled = printerInfo.textReceiptIsEnabled
                }
                
                if indexPath.row == 1 {     // Text Receipt (UTF8)
                    userInteractionEnabled = printerInfo.UTF8IsEnabled
                }
                
                if indexPath.row == 2 ||     // Raster Receipt
                    indexPath.row == 3 ||     // Raster Receipt (Both Scale)
                    indexPath.row == 4 {      // Raster Receipt (Scale)
                    userInteractionEnabled = printerInfo.rasterReceiptIsEnabled
                }
                
                if AppDelegate.getSelectedLanguage() == LanguageIndex.cjkUnifiedIdeograph {
                    userInteractionEnabled = printerInfo.CJKIsEnabled
                }
                
                if userInteractionEnabled == true &&
                    AppDelegate.settingManager.settings[1] != nil {
                    cell.textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
                else {
                    cell.textLabel!.alpha = 0.3
                    cell.detailTextLabel!.alpha = 0.3
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.none
                    
                    cell.isUserInteractionEnabled = false
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Backup Device"
        case 1:
            return "Sample"
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "PushSearchSubPortViewController",
                              sender: self)
            
        } else if indexPath.section == 1 {
            let commands: Data
            
            let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
            
            let width: Int = AppDelegate.getSelectedPaperSize().rawValue
            
            let paperSize: PaperSizeIndex = AppDelegate.getSelectedPaperSize()
            let language: LanguageIndex = AppDelegate.getSelectedLanguage()
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(language,
                                                                                              paperSizeIndex: paperSize)
            
            if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
                switch indexPath.row {
                case 0:
                    commands = PrinterFunctions.createTextReceiptData(emulation,
                                                                      localizeReceipts: localizeReceipts,
                                                                      utf8: false)
                case 1:
                    commands = PrinterFunctions.createTextReceiptData(emulation,
                                                                      localizeReceipts: localizeReceipts,
                                                                      utf8: true)
                case 2:
                    commands = PrinterFunctions.createRasterReceiptData(emulation,
                                                                        localizeReceipts: localizeReceipts)
                case 3:
                    commands = PrinterFunctions.createScaleRasterReceiptData(emulation,
                                                                             localizeReceipts: localizeReceipts,
                                                                             width: width,
                                                                             bothScale: true)
                case 4:
                    commands = PrinterFunctions.createScaleRasterReceiptData(emulation,
                                                                             localizeReceipts: localizeReceipts,
                                                                             width: width,
                                                                             bothScale: false)
                case 5:
                    commands = PrinterFunctions.createCouponData(emulation,
                                                                 localizeReceipts: localizeReceipts,
                                                                 width: width,
                                                                 rotation: .normal)
                case 6:
                    commands = PrinterFunctions.createCouponData(emulation,
                                                                 localizeReceipts: localizeReceipts,
                                                                 width: width,
                                                                 rotation: .right90)
                default:
                    fatalError()
                }
            }
            else {
                commands = PrinterFunctions.createTextReceiptData(emulation,
                                                                  localizeReceipts: localizeReceipts,
                                                                  utf8: true)
            }
            
            self.blind = true
            
            Communication.sendCommandsForPrintReDirection(commands,
                                                          timeout: 10000) { (communicationResultArray) in
                                                            self.blind = false
                                                            
                                                            var message: String = ""
                                                            
                                                            for i in 0..<communicationResultArray.count {
                                                                if i == 0 {
                                                                    message += "[Destination]\n"
                                                                }
                                                                else {
                                                                    message += "[Backup]\n"
                                                                }
                                                                
                                                                message += "Port Name: " + communicationResultArray[i].0 + "\n"
                                                                
                                                                switch communicationResultArray[i].1.result {
                                                                case .success:
                                                                    message += "----> Success!\n\n";
                                                                case .errorOpenPort:
                                                                    message += "----> Fail to openPort\n\n";
                                                                case .errorBeginCheckedBlock:
                                                                    message += "----> Printer is offline (beginCheckedBlock)\n\n";
                                                                case .errorEndCheckedBlock:
                                                                    message += "----> Printer is offline (endCheckedBlock)\n\n";
                                                                case .errorReadPort:
                                                                    message += "----> Read port error (readPort)\n\n";
                                                                case .errorWritePort:
                                                                    message += "----> Write port error (writePort)\n\n";
                                                                default:
                                                                    message += "----> Unknown error\n\n";
                                                                }
                                                            }
                                                            
                                                            self.showSimpleAlert(title: "Communication Result",
                                                                                 message: message,
                                                                                 buttonTitle: "OK",
                                                                                 buttonStyle: .cancel)}
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "PushSearchSubPortViewController":
            let vc = segue.destination as? SearchPortViewController
            if let vc = vc {
                vc.selectedPrinterIndex = 1
            }
        default:
            break
        }
    }
}
