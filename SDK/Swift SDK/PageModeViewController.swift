//
//  PageModeViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

class PageModeViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
            switch indexPath.row {
            case 0 :
                cell.textLabel!.text = String(format: "%@ %@ Text Label (Rotation0)",   localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 1 :
                cell.textLabel!.text = String(format: "%@ %@ Text Label (Rotation90)",  localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 2 :
                cell.textLabel!.text = String(format: "%@ %@ Text Label (Rotation180)", localizeReceipts.languageCode, localizeReceipts.paperSize)
//          case 3  :
            default :
                cell.textLabel!.text = String(format: "%@ %@ Text Label (Rotation270)", localizeReceipts.languageCode, localizeReceipts.paperSize)
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Like a StarIO-SDK Sample"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let commands: Data
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        let width: Int = AppDelegate.getSelectedPaperSize().rawValue
        
        let height: Int = 30 * 8     // 30mm!!!
        
        let rect:     CGRect
        let rotation: SCBBitmapConverterRotation
        
        switch indexPath.row {
        case 0 :
            rect = CGRect(x: 0, y: 0, width: width,  height: height)
            
            rotation = SCBBitmapConverterRotation.normal
        case 1 :
////        rect = CGRect(x: 0, y: 0, width: width,  height: height)
//          rect = CGRect(x: 0, y: 0, width: height, height: width)
            rect = CGRect(x: 0, y: 0, width: width,  height: width)
            
            rotation = SCBBitmapConverterRotation.right90
        case 2 :
            rect = CGRect(x: 0, y: 0, width: width,  height: height)
            
            rotation = SCBBitmapConverterRotation.rotate180
//      case 3  :
        default :
//          rect = CGRect(x: 0, y: 0, width: width,  height: height)
            rect = CGRect(x: 0, y: 0, width: height, height: width)
            
            rotation = SCBBitmapConverterRotation.left90
        }
        
        commands = PrinterFunctions.createTextPageModeData(emulation, localizeReceipts: localizeReceipts, rect: rect, rotation: rotation, utf8: false)
        
        self.blind = true
        
        let portName:     String = AppDelegate.getPortName()
        let portSettings: String = AppDelegate.getPortSettings()
        let timeout:      UInt32 = 10000                             // 10000mS!!!
        
        GlobalQueueManager.shared.serialQueue.async {
            _ = Communication.sendCommands(commands,
                                           portName: portName,
                                           portSettings: portSettings,
                                           timeout: timeout,
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
