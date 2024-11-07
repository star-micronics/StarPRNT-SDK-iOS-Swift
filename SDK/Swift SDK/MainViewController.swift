//
//  MainViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class MainViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    enum SectionIndex: Int {
        case device = 0
        case printer
        case peripheral
        case combination
        case api
        case deviceStatus
        case bluetooth
        case appendix
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title: String = "StarPRNT Swift SDK"
        
        let version: String = String(format: "Ver.%@", Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        
        self.navigationItem.title = String(format: "%@ %@", title, version)
        
        self.selectedIndexPath = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionIndex.appendix.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SectionIndex.device.rawValue {
            return 1
        }
        
        if section == SectionIndex.printer.rawValue {
            return 7
        }
        
        if section == SectionIndex.peripheral.rawValue {
            return 4
        }
        
        if section == SectionIndex.deviceStatus.rawValue {
            return 2
        }
        
        if section == SectionIndex.bluetooth.rawValue {
            return 3
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if SectionIndex(rawValue: indexPath.section)! == SectionIndex.device {
            if AppDelegate.settingManager.settings[0] == nil {
                let cellIdentifier: String = "UITableViewCellStyleValue1"
                
                cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
                
                if cell == nil {
                    cell = UITableViewCell(style: UITableViewCell.CellStyle.value1,
                                           reuseIdentifier: cellIdentifier)
                }
                
                if cell != nil {
                    cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                    
                    cell      .textLabel!.text = "Unselected State"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor.red
                    cell.detailTextLabel!.textColor = UIColor.red
                    
                    cell      .textLabel!.alpha = 0.0
                    cell.detailTextLabel!.alpha = 0.0
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   options: [.repeat, .autoreverse, .curveEaseIn],
                                   animations: {
                        cell      .textLabel!.alpha = 1.0
                        cell.detailTextLabel!.alpha = 1.0
                    })
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
            }
            else {
                let currentSetting = AppDelegate.settingManager.settings[indexPath.row]!
                
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
        }
        else {
            let cellIdentifier: String = "UITableViewCellStyleValue1"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            
            if cell != nil {
                switch SectionIndex(rawValue: indexPath.section)! {
                case SectionIndex.printer :
                    cell.backgroundColor = UIColor.white
                    
                    switch indexPath.row {
                    case 0:
                        cell.textLabel!.text = "Sample"
                        cell.detailTextLabel!.text = ""
                    case 1:
                        cell.textLabel!.text = "Black Mark Sample"
                        cell.detailTextLabel!.text = ""
                    case 2:
                        cell.textLabel!.text = "Black Mark Sample (Paste)"
                        cell.detailTextLabel!.text = ""
                    case 3:
                        cell.textLabel!.text = "Page Mode Sample"
                        cell.detailTextLabel!.text = ""
                    case 4:
                        cell.textLabel?.text = "Print Re-Direction Sample"
                        cell.detailTextLabel?.text = ""
                    case 5:
                        cell.textLabel?.text = "Hold Print Sample"
                        cell.detailTextLabel?.text = ""
                    case 6:
                        cell.textLabel?.text = "AutoSwitch Interface Sample"
                        cell.detailTextLabel?.text = ""
                    default :
                        fatalError()
                    }
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.peripheral:
                    cell.backgroundColor = UIColor.white
                    
                    switch indexPath.row {
                    case 0:
                        cell.textLabel!.text = "Cash Drawer Sample"
                    case 1:
                        cell.textLabel!.text = "Barcode Reader Sample"
                    case 2:
                        cell.textLabel!.text = "Display Sample"
                    case 3:
                        cell.textLabel!.text = "Melody Speaker Sample"
                    default:
                        fatalError()
                    }

                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.combination :
                    cell.backgroundColor = UIColor.white
                    
                    cell      .textLabel!.text = "StarIoExtManager Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.api :
                    cell.backgroundColor = UIColor.white
                    
                    cell      .textLabel!.text = "Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.deviceStatus :
                    cell.backgroundColor = UIColor.white
                    
                    switch indexPath.row {
                    case 0 :
                        cell      .textLabel!.text = "Sample"
                        cell.detailTextLabel!.text = ""
//                  case 1  :
                    default :
                        cell      .textLabel!.text = "Product Serial Number"
                        cell.detailTextLabel!.text = ""
                    }
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.bluetooth :
                    cell.backgroundColor = UIColor.white
                    
                    switch indexPath.row {
                    case 0 :
                        cell      .textLabel!.text = "Pairing and Connect Bluetooth"
                        cell.detailTextLabel!.text = ""
                    case 1 :
                        cell      .textLabel!.text = "Disconnect Bluetooth"
                        cell.detailTextLabel!.text = ""
//                  case 2  :
                    default :
                        cell      .textLabel!.text = "Bluetooth Setting"
                        cell.detailTextLabel!.text = ""
                    }
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
//              case SectionIndex.appendix :
                default                    :
                    cell.backgroundColor = UIColor.white
                    
                    cell      .textLabel!.text = "Framework Version"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                }
                
                var userInteractionEnabled: Bool = true
                
                if let modelIndex = AppDelegate.getSelectedModelIndex() {
                    if let printerInfo = ModelCapability.modelCapabilityDictionary[modelIndex] {
                        switch (indexPath.section, indexPath.row) {
                        case (SectionIndex.printer.rawValue, 1...2):    // Black Mark, Black Mark (Paste)
                            userInteractionEnabled = printerInfo.blackMarkIsEnabled
                        case (SectionIndex.printer.rawValue, 3):        // Page Mode Sample
                            userInteractionEnabled = printerInfo.pageModeIsEnabled
                        case (SectionIndex.printer.rawValue, 4):
                            if AppDelegate.settingManager.settings[0] != nil {
                                userInteractionEnabled = true
                            } else {
                                userInteractionEnabled = false
                            }
                        case (SectionIndex.printer.rawValue, 5):
                            userInteractionEnabled = printerInfo.paperPresentStatusIsEnabled
                        case (SectionIndex.printer.rawValue, 6):
                            userInteractionEnabled = printerInfo.autoSwitchInterfaceIsEnabled
                        case (SectionIndex.peripheral.rawValue, 0):
                            userInteractionEnabled = printerInfo.cashDrawerIsEnabled
                        case (SectionIndex.peripheral.rawValue, 1),
                             (SectionIndex.combination.rawValue, _):
                            userInteractionEnabled = printerInfo.barcodeReaderIsEnabled
                        case (SectionIndex.peripheral.rawValue, 2):
                            userInteractionEnabled = printerInfo.customerDisplayIsEnabled
                        case (SectionIndex.peripheral.rawValue, 3):
                            userInteractionEnabled = printerInfo.melodySpeakerIsEnabled
                        case (SectionIndex.deviceStatus.rawValue, 1):   // Product Serial Number
                            let modelName = AppDelegate.getModelName()
                            if modelName.hasPrefix("TSP113 ") || modelName.hasPrefix("TSP143 ") {
                                userInteractionEnabled = false
                            } else {
                                userInteractionEnabled = printerInfo.productSerialNumberIsEnabled
                            }
                        case (SectionIndex.bluetooth.rawValue, 1):
                            userInteractionEnabled = printerInfo.supportBluetoothDisconnection
                        default:
                            break
                        }
                    } else {
                        userInteractionEnabled = false
                    }
                } else {
                    userInteractionEnabled = false
                }
                
                if indexPath.section == SectionIndex.bluetooth.rawValue {
                    if indexPath.row == 0 {     // Pairing and Connect Bluetooth
                        userInteractionEnabled = true
                    }
                    if indexPath.row == 1 {     // Disconnect Bluetooth
                        if AppDelegate.getPortName().hasPrefix("BT:") == false {
                            userInteractionEnabled = false
                        }
                    }
                    if indexPath.row == 2 {     // Bluetooth Setting
                        if AppDelegate.getPortName().hasPrefix("BT:")  == false &&
                            AppDelegate.getPortName().hasPrefix("BLE:") == false {
                            userInteractionEnabled = false
                        }
                    }
                }
                
                if indexPath.section == SectionIndex.appendix.rawValue {
                    userInteractionEnabled = true
                }
                
                if userInteractionEnabled == true {
                    cell      .textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
                else {
                    cell      .textLabel!.alpha = 0.3
                    cell.detailTextLabel!.alpha = 0.3
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.none
                    
                    cell.isUserInteractionEnabled = false
                }
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String!
        
        switch SectionIndex(rawValue: section)! {
        case SectionIndex.device :
            title = "Destination Device"
        case SectionIndex.printer :
            title = "Printer"
        case SectionIndex.peripheral:
            title = "Peripheral"
        case SectionIndex.combination :
            title = "Combination"
        case SectionIndex.api :
            title = "API"
        case SectionIndex.deviceStatus :
            title = "Device Status"
        case SectionIndex.bluetooth :
            title = "Interface"
        case SectionIndex.appendix :
            title = "Appendix"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedIndexPath = indexPath
        
        let selectedSection = SectionIndex(rawValue: self.selectedIndexPath.section)!
        
        switch (selectedSection, self.selectedIndexPath.row) {
        case (SectionIndex.device, _):
            self.performSegue(withIdentifier: "PushSearchPortViewController", sender: nil)
        case (SectionIndex.printer, 0):
            self.showLanguageSelectionAlert(title: "Select Language.",
                                            languages: [.english, .japanese, .french,
                                                        .portuguese, .spanish, .german,
                                                        .russian, .simplifiedChinese,
                                                        .traditionalChinese, .cjkUnifiedIdeograph]) { (optSelectedLanguage) in
                                                            guard let selectedLanguage = optSelectedLanguage else {
                                                                return
                                                            }
                                                            
                                                            AppDelegate.setSelectedLanguage(selectedLanguage)
                                                            
                                                            self.performSegue(withIdentifier: "PushPrinterViewController",
                                                                              sender: nil)
            }
            return
        case (SectionIndex.printer, 1):
            self.showLanguageSelectionAlert(title: "Select language.",
                                            languages: [.english, .japanese],
                                            completion: { (optSelectedLanguage) in
                                                guard let selectedLanguage = optSelectedLanguage else {
                                                    return
                                                }
                                                AppDelegate.setSelectedLanguage(selectedLanguage)
                                                
                                                self.performSegue(withIdentifier: "PushBlackMarkViewController",
                                                                  sender: nil)
            })
            
        case (SectionIndex.printer, 2):
            self.showLanguageSelectionAlert(title: "Select language.",
                                            languages: [.english, .japanese],
                                            completion: { (optSelectedLanguage) in
                                                guard let selectedLanguage = optSelectedLanguage else {
                                                    return
                                                }
                                                AppDelegate.setSelectedLanguage(selectedLanguage)
                                                
                                                self.performSegue(withIdentifier: "PushBlackMarkPasteViewController",
                                                                  sender: nil)
            })
        case (SectionIndex.printer, 3):
            self.showLanguageSelectionAlert(title: "Select language.",
                                            languages: [.english, .japanese],
                                            completion: { (optSelectedLanguage) in
                                                guard let selectedLanguage = optSelectedLanguage else {
                                                    return
                                                }
                                                AppDelegate.setSelectedLanguage(selectedLanguage)
                                                
                                                self.performSegue(withIdentifier: "PushPageModeViewController",
                                                                  sender: nil)
            })
        case (SectionIndex.printer, 4):
            self.showLanguageSelectionAlert(title: "Select Language.",
                                            languages: [.english, .japanese,
                                                        .french, .portuguese,
                                                        .spanish, .german,
                                                        .russian, .simplifiedChinese,
                                                        .traditionalChinese],
                                            completion: { (optSelectedLanguage) in
                                                guard let selectedLanguage = optSelectedLanguage else {
                                                    return
                                                }
                                                
                                                AppDelegate.setSelectedLanguage(selectedLanguage)
                                                self.performSegue(withIdentifier: "PushPrintReDirectionViewController",
                                                                  sender: nil)
            })
        case (SectionIndex.printer, 5):
            self.performSegue(withIdentifier: "PushHoldPrintViewController", sender: nil)
        case (SectionIndex.printer, 6):
            self.showAlert(title: "Select Sample",
                           buttonTitles: ["StarIO Sample", "StarIoExtManager Sample"],
                           handler: { selectedIndex in
                            var segueIdentifier: String
                            
                            switch selectedIndex {
                            case 1:
                                segueIdentifier = "PushAutoSwitchInterfaceViewController"
                            case 2:
                                segueIdentifier = "PushAutoSwitchInterfaceExtViewController"
                            default:
                                fatalError()
                            }
                            self.performSegue(withIdentifier: segueIdentifier,
                                              sender: nil)
        })
        case (SectionIndex.peripheral, 0):
            self.performSegue(withIdentifier: "PushCashDrawerViewController", sender: nil)
        case (SectionIndex.peripheral, 1):
            self.performSegue(withIdentifier: "PushBarcodeReaderExtViewController", sender: nil)
        case (SectionIndex.peripheral, 2):
            self.performSegue(withIdentifier: "PushDisplayViewController", sender: nil)
        case (SectionIndex.peripheral, 3):
            self.performSegue(withIdentifier: "PushMelodySpeakerViewController", sender: nil)
        case (SectionIndex.combination, _):
            self.showLanguageSelectionAlert(title: "Select language.",
                                            languages: [.english, .japanese, .french,
                                                        .portuguese, .spanish, .german, .russian,
                                                        .simplifiedChinese, .traditionalChinese],
                                            completion: { (optSelectedLanguage) in
                                                guard let selectedLanguage = optSelectedLanguage else {
                                                    return
                                                }
                                                AppDelegate.setSelectedLanguage(selectedLanguage)
                                                
                                                self.performSegue(withIdentifier: "PushCombinationViewController",
                                                                  sender: nil)
            })
        case (SectionIndex.api, _):
            self.performSegue(withIdentifier: "PushApiViewController", sender: nil)
        case (SectionIndex.deviceStatus, 0):
            self.performSegue(withIdentifier: "PushDeviceStatusViewController", sender: nil)
        case (SectionIndex.deviceStatus, 1):
            self.confirmSerialNumber()
        case (SectionIndex.bluetooth, 0):
            Communication.connectBluetooth({ (result: Bool, title: String?, message: String?) in
                if title   != nil ||
                    message != nil {
                    self.showSimpleAlert(title: title,
                                         message: message,
                                         buttonTitle: "OK",
                                         buttonStyle: .cancel)
                }
            })
        case (SectionIndex.bluetooth, 1):
                self.setBlind(true)

                defer {
                    self.setBlind(false)
                }
                
                let modelName:    String = AppDelegate.getModelName()
                let portName:     String = AppDelegate.getPortName()
                let portSettings: String = AppDelegate.getPortSettings()
                
                _ = Communication.disconnectBluetooth(modelName,
                                                      portName: portName,
                                                      portSettings: portSettings,
                                                      timeout: 10000,
                                                      completionHandler: { (communicationResult: CommunicationResult) in
                                                        var message: String = Communication.getCommunicationResultMessage(communicationResult)
                                                        
                                                        if communicationResult.result != .success {
                                                            message += "\nNote. Portable Printers are not supported."
                                                        }
                                                        
                                                        self.showSimpleAlert(title: "Communication Result",
                                                                             message: message,
                                                                             buttonTitle: "OK",
                                                                             buttonStyle: .cancel)
                })
        case (SectionIndex.bluetooth, 2):
                self.performSegue(withIdentifier: "PushBluetoothSettingViewController", sender: nil)
        case (SectionIndex.appendix, _):
            let message = """
            StarIO version \(SMPort.starIOVersion() ?? "")
            \(StarIoExt.description() ?? "")
            """
            
            self.showSimpleAlert(title: "Framework Version",
                                 message: message,
                                 buttonTitle: "OK",
                                 buttonStyle: .default)
        default:
            fatalError()
        }
    }
    
    func showLanguageSelectionAlert(title: String,
                                    languages:[LanguageIndex],
                                    completion: ((LanguageIndex?) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        func addSelection(language: LanguageIndex?, title: String, style: UIAlertAction.Style) {
            let alertAction = UIAlertAction(title: title, style: .default, handler: { _ in
                DispatchQueue.main.async {
                    completion?(language)
                }
            })
            alert.addAction(alertAction)
        }
        
        languages.forEach { (language) in
            switch language {
            case .english:
                addSelection(language: language, title: "English", style: .default)
            case .japanese:
                addSelection(language: language, title: "Japanese", style: .default)
            case .french:
                addSelection(language: language, title: "French", style: .default)
            case .portuguese:
                addSelection(language: language, title: "Portuguese", style: .default)
            case .spanish:
                addSelection(language: language, title: "Spanish", style: .default)
            case .german:
                addSelection(language: language, title: "German", style: .default)
            case .russian:
                addSelection(language: language, title: "Russian", style: .default)
            case .simplifiedChinese:
                addSelection(language: language, title: "Simplified Chinese", style: .default)
            case .traditionalChinese:
                addSelection(language: language, title: "Traditional Chinese", style: .default)
            case .cjkUnifiedIdeograph:
                addSelection(language: language, title: "UTF8 Multi language", style: .default)
            }
        }
        
        addSelection(language: nil, title: "Cancel", style: .cancel)
        
        self.present(alert, animated: true)
    }
    
    fileprivate func confirmSerialNumber() {
        self.setBlind(true)
        
        defer {
            self.setBlind(false)
        }
        
        let portName:     String = AppDelegate.getPortName()
        let portSettings: String = AppDelegate.getPortSettings()
        let timeout:      UInt32 = 10000
        
        _ = Communication.confirmSerialNumber(portName,
                                              portSettings: portSettings,
                                              timeout: timeout,
                                              completionHandler: { (communicationResult: CommunicationResult, message: String) in
                                                var dialogMessage: String = ""
                                                
                                                if communicationResult.result == .success {
                                                    dialogMessage = message
                                                }
                                                else {
                                                    dialogMessage = Communication.getCommunicationResultMessage(communicationResult)
                                                }
                                                
                                                self.showSimpleAlert(title: "Product Serial Number",
                                                                     message: dialogMessage,
                                                                     buttonTitle: "OK",
                                                                     buttonStyle: .cancel)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "PushSearchPortViewController":
            let vc = segue.destination as? SearchPortViewController
            if let vc = vc {
                vc.selectedPrinterIndex = self.selectedIndexPath.row
            }
        default:
            break
        }
    }
}
