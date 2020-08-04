//
//  PrinterViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CustomUIImagePickerController: UIImagePickerController {
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if AppDelegate.isIPad() {
            return UIInterfaceOrientationMask.all
        }
        
        return UIInterfaceOrientationMask.allButUpsideDown
    }
}

class PrinterViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
        if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
            return 3
        }
        else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
            if section == 0 {
                return 7
            } else if section == 1 {
                return 8
            } else {
                return 2
            }
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            if indexPath.section != 2 {
                let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
                
                if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
                    switch indexPath.row {
                    case 0:
                        cell.textLabel!.text = String(format: "%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize)
                    case 1:
                        cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize)
                    case 2:
                        cell.textLabel!.text = String(format: "%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize)
                    case 3:
                        cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
                    case 4:
                        cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
                    case 5:
                        cell.textLabel!.text = String(format: "%@ Raster Coupon",                  localizeReceipts.languageCode)
                    case 6:
                        cell.textLabel!.text = String(format: "%@ Raster Coupon (Rotation90)",     localizeReceipts.languageCode)
                    //case 7:
                    default :
                        let receiptTypeTitle: String
                        if AppDelegate.getEmulation() == .starDotImpact {
                            receiptTypeTitle = "Text";
                        } else {
                            receiptTypeTitle = "Raster";
                        }
                        
                        cell.textLabel!.text = String(format: "%@ %@ %@ Receipt (connectAsync)",
                                                      localizeReceipts.languageCode,
                                                      localizeReceipts.paperSize,
                                                      receiptTypeTitle)
                    }
                }
                else {
                    cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)", localizeReceipts.languageCode, localizeReceipts.paperSize)
                }
                
                cell.detailTextLabel!.text = ""
                
                cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                
//              cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
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
            else {
                if indexPath.row == 0 {
                    cell.textLabel!.text = "Print Photo from Library"
                }
                else {
                    cell.textLabel!.text = "Print Photo by Camera"
                }
                
                cell.detailTextLabel!.text = ""
                
                cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                
                cell      .textLabel!.alpha = 1.0
                cell.detailTextLabel!.alpha = 1.0
                
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                
                cell.isUserInteractionEnabled = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        
        if section == 0 {
            title = "Like a StarIO-SDK Sample"
        }
        else if section == 1 {
            title = "StarIoExtManager Sample"
        }
        else {
            title = "Appendix"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let commands: Data
            
            let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
            
            let width: Int = AppDelegate.getSelectedPaperSize().rawValue
            
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
            if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
                switch indexPath.row {
                case 0 :
                    commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false)
                case 1 :
                    commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true)
                case 2 :
                    commands = PrinterFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts)
                case 3 :
                    commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true)
                case 4 :
                    commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false)
                case 5 :
                    commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.normal)
//              case 6  :
                default :
                    commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.right90)
                }
            }
            else {
                commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true)
            }
            
            self.blind = true
            
            let portName: String = AppDelegate.getPortName()
            let portSettings: String = AppDelegate.getPortSettings()
            
            GlobalQueueManager.shared.serialQueue.async {
                _ = Communication.sendCommands(commands,
                                               portName: portName,
                                               portSettings: portSettings,
                                               timeout: 10000,  // 10000mS!!!
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
        else if indexPath.section == 1 {
            if AppDelegate.getSelectedLanguage() != LanguageIndex.cjkUnifiedIdeograph {
                AppDelegate.setSelectedIndex(indexPath.row)
            }
            else {
                AppDelegate.setSelectedIndex(1)
            }
        
            let identifier = (indexPath.row == 7) ? "PushPrinterExtWithConnectAsyncViewController" : "PushPrinterExtViewController"
            self.performSegue(withIdentifier: identifier, sender: nil)
        }
        else {
            if indexPath.row == 0 {
//              let imagePickerController:       UIImagePickerController =       UIImagePickerController()
                let imagePickerController: CustomUIImagePickerController = CustomUIImagePickerController()
                
                imagePickerController.sourceType    = UIImagePickerController.SourceType.photoLibrary
                imagePickerController.allowsEditing = false
                imagePickerController.delegate      = self
                
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                let imagePickerController: UIImagePickerController = UIImagePickerController()
                
                imagePickerController.sourceType    = UIImagePickerController.SourceType.camera
                imagePickerController.allowsEditing = false
                imagePickerController.delegate      = self
                
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: {
            let commands: Data
            
            let builder: ISCBBuilder = StarIoExt.createCommandBuilder(AppDelegate.getEmulation())
            
            builder.beginDocument()
            
            builder.appendBitmap(image, diffusion: true, width: AppDelegate.getSelectedPaperSize().rawValue, bothScale: true)
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            commands = builder.commands.copy() as! Data
            
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
        })
    }
}
