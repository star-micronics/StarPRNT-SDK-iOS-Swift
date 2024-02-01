//
//  CashDrawerViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CashDrawerViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
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
        return 2
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
            switch indexPath.row {
            case 0 :
                cell.textLabel!.text = "Channel1 (Check condition.)"
            case 1 :
                cell.textLabel!.text = "Channel1 (Do not check condition.)"
            case 2 :
                cell.textLabel!.text = "Channel2 (Check condition.)"
//          case 3  :
            default :
                cell.textLabel!.text = "Channel2 (Do not check condition.)"
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        
        if section == 0 {
            title = "Like a StarIO-SDK Sample"
        }
        else {
            title = "StarIoExtManager Sample"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let commands: Data
            
            switch indexPath.row {
            case 0, 1 :
                commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.no1)
//          case 2, 3 :
            default   :
                commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.no2)
            }

            let portName:     String = AppDelegate.getPortName()
            let portSettings: String = AppDelegate.getPortSettings()
            let timeout:      UInt32 = 10000                             // 10000mS!!!
            
            self.blind = true
            
            GlobalQueueManager.shared.serialQueue.async {
                switch indexPath.row {
                case 0, 2 :
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
                // case 1, 3 :
                default   :
                    _ = Communication.sendCommandsDoNotCheckCondition(commands,
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
        else {
            AppDelegate.setSelectedIndex(indexPath.row)
            
            self.performSegue(withIdentifier: "PushCashDrawerExtViewController", sender: nil)
        }
    }
}
