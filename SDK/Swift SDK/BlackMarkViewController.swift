//
//  BlackMarkViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

import UIKit

class BlackMarkViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var detectionSwitch: UISwitch!
    
    @IBOutlet weak var detectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modelIndex = AppDelegate.getSelectedModelIndex()
        
        let printerInfo = ModelCapability.modelCapabilityDictionary[modelIndex!]!
        
        if printerInfo.blackMarkDetectionIsEnabled {
            self.detectionSwitch.isEnabled = true
            self.detectionLabel.isEnabled = true
            self.detectionLabel.alpha = 1.0
        } else {
            self.detectionSwitch.isEnabled = false
            self.detectionLabel.isEnabled = false
            self.detectionLabel.alpha = 0.3
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
//          cell.textLabel!.text = String(format: "%@ %@ Text Label", localizeReceipts.languageCode, localizeReceipts.paperSize)
            cell.textLabel!.text = String(format: "%@ Text Label",    localizeReceipts.languageCode)
            
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
        
        let type: SCBBlackMarkType
        
        if self.detectionSwitch.isOn == false {
            type = SCBBlackMarkType.valid
        }
        else {
            type = SCBBlackMarkType.validWithDetection
        }
        
        commands = PrinterFunctions.createTextBlackMarkData(emulation, localizeReceipts: localizeReceipts, type: type, utf8: false)
        
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
