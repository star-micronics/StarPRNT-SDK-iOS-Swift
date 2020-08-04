//
//  AllReceiptsViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class AllReceiptsViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, SwitchTableViewCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number: Int
        
        switch section {
        case 0, 1 :
            number = 5
        case 2 :
            number = 1
//      case 3  :
        default :
            number = 3
        }
        
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.section == 0 ||
           indexPath.section == 1 {
            let cellIdentifier: String = "UITableViewCellStyleValue1"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            
            if cell != nil {
                cell.backgroundColor = UIColor.white
                
                let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
                
                switch indexPath.row {
                case 0 :
                    cell.textLabel!.text = String(format: "%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize)
                case 1 :
                    cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize)
                case 2 :
                    cell.textLabel!.text = String(format: "%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize)
                case 3 :
                    cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
//              case 4  :
                default :
                    cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
                }
                
                cell.detailTextLabel!.text = ""
                
                cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                
//              cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
                
                let optModelIndex = AppDelegate.getSelectedModelIndex()
                guard let modelIndex = optModelIndex else {
                    fatalError()
                }
                
                guard let printerInfo = ModelCapability.modelCapabilityDictionary[modelIndex] else {
                    fatalError()
                }
                
                var userInteractionEnabled: Bool = true
                
                if SMCloudServices.isRegistered() == false {
                    userInteractionEnabled = false
                } else {
                    if indexPath.row == 0 {     // Text Receipt
                        userInteractionEnabled = printerInfo.textReceiptIsEnabled
                    }
                
                    if indexPath.row == 1 {     // Text Receipt (UTF8)
                        userInteractionEnabled = printerInfo.UTF8IsEnabled && printerInfo.textReceiptIsEnabled
                    }
                }
                
                if userInteractionEnabled == true {
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
        else if indexPath.section == 2 {
            let cellIdentifier: String = "UITableViewCellStyleValue1"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            
            if cell != nil {
                cell.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.9, alpha: 1.0)
                
                if SMCloudServices.isRegistered() == false {
                    cell      .textLabel!.text = "Unregistered Device"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor.red
                    cell.detailTextLabel!.textColor = UIColor.red
                    
                    UIView.beginAnimations(nil, context: nil)
                    
                    cell      .textLabel!.alpha = 0.0
                    cell.detailTextLabel!.alpha = 0.0
                    
                    UIView.setAnimationDelay             (0.0)                             // 0mS!!!
                    UIView.setAnimationDuration          (0.6)                             // 600mS!!!
                    UIView.setAnimationRepeatCount       (Float(UINT32_MAX))
                    UIView.setAnimationRepeatAutoreverses(true)
                    UIView.setAnimationCurve             (UIView.AnimationCurve.easeIn)
                    
                    cell      .textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    UIView.commitAnimations()
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
                else {
                    cell.textLabel!      .text = "Registration Details"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor.blue
                    cell.detailTextLabel!.textColor = UIColor.blue
                    
                    cell      .textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
            }
        }
        else {     // section == 3
            let cellIdentifier: String = "SwitchTableViewCell"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            if cell != nil {
                let customCell: SwitchTableViewCell = cell as! SwitchTableViewCell
                
                customCell.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0)
                
                customCell.stateSwitch.isOn = true
                
                let allReceiptsSettings: Int = AppDelegate.getAllReceiptsSettings()
                
                switch (indexPath.row) {
                case 0 :
                    customCell.titleLabel.text = "Receipt"
                    
                    if (allReceiptsSettings & 0x00000001) == 0x00000000 {
                        customCell.stateSwitch.isOn = false
                    }
                case 1 :
                    customCell.titleLabel.text = "Information"
                    
                    if (allReceiptsSettings & 0x00000002) == 0x00000000 {
                        customCell.stateSwitch.isOn = false
                    }
//              case 2  :
                default :
                    customCell.titleLabel.text = "QR Code"
                    
                    if (allReceiptsSettings & 0x00000004) == 0x00000000 {
                        customCell.stateSwitch.isOn = false
                    }
                }
                
                customCell.titleLabel.textColor = UIColor.blue
                
                customCell.delegate = self
                
                var frame: CGRect = customCell.titleLabel.frame
                
                let insets: UIEdgeInsets = self.tableView.separatorInset
                
                frame.origin.x = insets.left
                
                customCell.titleLabel.frame = frame
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        
        switch section {
        case 0 :
            title = "Like a StarIO-SDK Sample"
        case 1 :
            title = "StarIoExtManager Sample"
        case 2 :
            title = "Procedure"
//      case 3  :
        default :
            title = "Print Setting"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
            
            let width: Int = AppDelegate.getSelectedPaperSize().rawValue
            
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
            let completionUpload: (Int, Error?) -> Void = {(statusCode, error) -> Void in
                let prompt: String
                
                if let error = error as NSError? {
                    prompt = String(format: "%@", error)
                }
                else {
                    prompt = String(format: "Status Code : %ld", statusCode)
                }
                
                NSLog("%@", prompt)
                
                self.navigationItem.prompt = prompt
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                    self.navigationItem.prompt = nil
                })
            }
            
            let commands: Data?
            
            var receipt: Bool = true
            var info:    Bool = true
            var qrCode:  Bool = true
            
            let allReceiptsSettings: Int = AppDelegate.getAllReceiptsSettings()
            
            if (allReceiptsSettings & 0x00000001) == 0x00000000 {
                receipt = false
            }
            
            if (allReceiptsSettings & 0x00000002) == 0x00000000 {
                info = false
            }
            
            if (allReceiptsSettings & 0x00000004) == 0x00000000 {
                qrCode = false
            }
            
            switch indexPath.row {
            case 0 :
                commands = AllReceiptsFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false, width: width, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
            case 1 :
                commands = AllReceiptsFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true,  width: width, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
            case 2 :
                commands = AllReceiptsFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
            case 3 :
                commands = AllReceiptsFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true,  receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
//          case 4  :
            default :
                commands = AllReceiptsFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
            }
            
            if commands != nil {
                self.blind = true
                
                let portName:     String = AppDelegate.getPortName()
                let portSettings: String = AppDelegate.getPortSettings()
                
                GlobalQueueManager.shared.serialQueue.async {
                    _ = Communication.sendCommands(commands,
                                                   portName: portName,
                                                   portSettings: portSettings,
                                                   timeout: 10000,
                                                   completionHandler: { (communicationResult: CommunicationResult) in
                                                    DispatchQueue.main.async {
                                                        self.showSimpleAlert(title: "Communication Result",
                                                                             message: Communication.getCommunicationResultMessage(communicationResult),
                                                                             buttonTitle: "OK",
                                                                             buttonStyle: .cancel)
                    
                                                        self.blind = false
                                                    }
                    })
                }
            }
        }
        else if indexPath.section == 1 {
            AppDelegate.setSelectedIndex(indexPath.row)
            
            self.performSegue(withIdentifier: "PushAllReceiptsExtViewController", sender: nil)
        }
        else if indexPath.section == 2 {
            SMCloudServices.showRegistrationView({ (Bool) -> Void in
                self.tableView.reloadData()
            })
        }
//      else {     // section == 3
//      }
    }
    
    func tableView(_ tableView: UITableView, valueChangedStateSwitch on: Bool, indexPath: IndexPath) {
        var allReceiptsSettings: Int = AppDelegate.getAllReceiptsSettings()
        
        if on == true {
            switch indexPath.row {
            case 0 :
                allReceiptsSettings |= 0x00000001
            case 1 :
                allReceiptsSettings |= 0x00000002
//          case 2  :
            default :
                allReceiptsSettings |= 0x00000004
            }
        }
        else {
            switch indexPath.row {
            case 0 :
                allReceiptsSettings &= 0x0000fffe
            case 1 :
                allReceiptsSettings &= 0x0000fffd
//          case 2  :
            default :
                allReceiptsSettings &= 0x0000fffb
            }
        }
        
        AppDelegate.setAllReceiptsSettings(allReceiptsSettings)
        AppDelegate.settingManager.save()
    }
}
