//
//  ApiViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class ApiViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 27
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            switch indexPath.row {
            case 0  :
                cell.textLabel!.text = "Generic"
            case 1  :
                cell.textLabel!.text = "Font Style"
            case 2  :
                cell.textLabel!.text = "Initialization"
            case 3  :
                cell.textLabel!.text = "Code Page"
            case 4  :
                cell.textLabel!.text = "International"
            case 5  :
                cell.textLabel!.text = "Feed"
            case 6  :
                cell.textLabel!.text = "Character Space"
            case 7  :
                cell.textLabel!.text = "Line Space"
            case 8:
                cell.textLabel!.text = "Top Margin"
            case 9  :
                cell.textLabel!.text = "Emphasis"
            case 10  :
                cell.textLabel!.text = "Invert"
            case 11 :
                cell.textLabel!.text = "Under Line"
            case 12 :
                cell.textLabel!.text = "Multiple"
            case 13 :
                cell.textLabel!.text = "Absolute Position"
            case 14 :
                cell.textLabel!.text = "Alignment"
            case 15 :
                cell.textLabel!.text = "Horizontal Tab Position"
            case 16 :
                cell.textLabel!.text = "Logo"
            case 17 :
                cell.textLabel!.text = "Cut Paper"
            case 18 :
                cell.textLabel!.text = "Peripheral"
            case 19 :
                cell.textLabel!.text = "Sound"
            case 20 :
                cell.textLabel!.text = "Bitmap"
            case 21 :
                cell.textLabel!.text = "Barcode"
            case 22 :
                cell.textLabel!.text = "PDF417"
            case 23 :
                cell.textLabel!.text = "QR Code"
            case 24 :
                cell.textLabel!.text = "Black Mark"
            case 25 :
                cell.textLabel!.text = "Page Mode"
            case 26:
                cell.textLabel!.text = "Printable Area"
            default :
                fatalError()
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sample"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        var commands: Data? = nil
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let width: Int = AppDelegate.getSelectedPaperSize().rawValue
        
        switch indexPath.row {
        case 0:
            commands = ApiFunctions.createGenericData(emulation)
        case 1:
            commands = ApiFunctions.createFontStyleData(emulation)
        case 2:
            commands = ApiFunctions.createInitializationData(emulation)
        case 3:
            commands = ApiFunctions.createCodePageData(emulation)
        case 4:
            commands = ApiFunctions.createInternationalData(emulation)
        case 5:
            commands = ApiFunctions.createFeedData(emulation)
        case 6:
            commands = ApiFunctions.createCharacterSpaceData(emulation)
        case 7:
            commands = ApiFunctions.createLineSpaceData(emulation)
        case 8:
            commands = ApiFunctions.createTopMarginData(emulation)
        case 9:
            commands = ApiFunctions.createEmphasisData(emulation)
        case 10:
            commands = ApiFunctions.createInvertData(emulation)
        case 11:
            commands = ApiFunctions.createUnderLineData(emulation)
        case 12:
            commands = ApiFunctions.createMultipleData(emulation)
        case 13:
            commands = ApiFunctions.createAbsolutePositionData(emulation)
        case 14:
            commands = ApiFunctions.createAlignmentData(emulation)
        case 15:
            commands = ApiFunctions.createHorizontalTabPositionData(emulation)
        case 16:
            commands = ApiFunctions.createLogoData(emulation)
        case 17:
            commands = ApiFunctions.createCutPaperData(emulation)
        case 18:
            commands = ApiFunctions.createPeripheralData(emulation)
        case 19:
            commands = ApiFunctions.createSoundData(emulation)
        case 20:
            commands = ApiFunctions.createBitmapData(emulation, width: width)
        case 21:
            commands = ApiFunctions.createBarcodeData(emulation)
        case 22:
            commands = ApiFunctions.createPdf417Data(emulation)
        case 23:
            commands = ApiFunctions.createQrCodeData(emulation)
        case 24:
            self.showBlackMarkTypeSelectionAlert { (optBlackMarkType) in
                guard let blackMarkType = optBlackMarkType else {
                    return
                }
                
                let emulation = AppDelegate.getEmulation()
                
                let commands = ApiFunctions.createBlackMarkData(emulation, type: blackMarkType)
                
                self.sendCommands(commands)
            }
        case 25:
            commands = ApiFunctions.createPageModeData(emulation, width: width)
        case 26:
            self.printPrintableAreaSample(emulation: emulation)
        default :
            fatalError()
        }
        
        if commands != nil {
            sendCommands(commands)
        }
    }
    
    func showBlackMarkTypeSelectionAlert(completion:@escaping (SCBBlackMarkType?) -> Void) {
        let alert = UIAlertController(title: "Select black mark type.",
                                      message: nil,
                                      preferredStyle: .alert)
        
        func addSelection(title: String, style: UIAlertAction.Style, blackMarkType: SCBBlackMarkType?) {
            let alertAction = UIAlertAction(title: title, style: .default, handler: { _ in
                DispatchQueue.main.async {
                    completion(blackMarkType)
                }
            })
            
            alert.addAction(alertAction)
        }
        
        addSelection(title: "Invalid", style: .default, blackMarkType: .invalid)
        addSelection(title: "Valid", style: .default, blackMarkType: .valid)
        addSelection(title: "Valid with Detection", style: .default, blackMarkType: .validWithDetection)
        addSelection(title: "Cancel", style: .cancel, blackMarkType: nil)
        
        self.present(alert, animated: true)
    }
    
    func printPrintableAreaSample(emulation: StarIoExtEmulation) {
        let alert = UIAlertController(title: "Select printable area type.",
                                      message: nil,
                                      preferredStyle: .alert)
        
        let printableAreaTypes: [(title: String, type: SCBPrintableAreaType)] = [("Standard", .standard),
                                                                                 ("Type1", .type1),
                                                                                 ("Type2", .type2),
                                                                                 ("Type3", .type3),
                                                                                 ("Type4", .type4)]
        
        printableAreaTypes.forEach { (title: String, type: SCBPrintableAreaType) in
            let action = UIAlertAction(title: title, style: .default) { [unowned self] (_) in
                let commands = ApiFunctions.createPrintableAreaData(emulation, type: type)

                self.sendCommands(commands)
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func sendCommands(_ commands: Data?) {
        let portName:     String = AppDelegate.getPortName()
        let portSettings: String = AppDelegate.getPortSettings()
        
        self.blind = true
        
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
