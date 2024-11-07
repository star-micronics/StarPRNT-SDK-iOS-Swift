//
//  HoldPrintViewController.swift
//  Swift SDK
//
//  Created by 上田　雄磨 on 2019/10/24.
//  Copyright © 2019 Star Micronics. All rights reserved.
//

import UIKit

class HoldPrintViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var holdingControlTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        holdingControlTableView.layer.borderWidth = 1.0
        holdingControlTableView.layer.borderColor = UIColor.lightGray.cgColor
        holdingControlTableView.delegate = self
        holdingControlTableView.dataSource = self
        holdingControlTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        holdingControlTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = UITableViewCell.AccessoryType.checkmark;
    }
    
    func print() {
        let portName: String = AppDelegate.getPortName()
        let portSettings: String = AppDelegate.getPortSettings()
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        var isHoldArrayTmp: [Bool]
        
        switch holdingControlTableView.indexPathForSelectedRow?.row {
        case 0: // Always hold
            isHoldArrayTmp = [true, true, true]
        case 1: // Hold before printing the last page
            isHoldArrayTmp = [false, true, false]
        case 2: // Do not Hold
            isHoldArrayTmp = [false, false, false]
        default:
            fatalError()
        }
        
        let isHoldArray = isHoldArrayTmp
        
        let commandArray = PrinterFunctions.createHoldPrintData(emulation, isHoldArray: isHoldArray)
        
        self.setBlind(true)

        let removePaperAlert = UIAlertController.init(title: "Confirm", message: "Please remove paper from printer.", preferredStyle: UIAlertController.Style.alert)
        
        GlobalQueueManager.shared.serialQueue.async {
            _ = Communication.sendCommandsMultiplePages(commandArray,
                                                        portName: portName,
                                                        portSettings: portSettings,
                                                        timeout: 10000,
                                                        holdPrintTimeout: 10000,
                                                        pageStartHandler: nil,
                                                        pageFinishHandler:  { (index: Int) in
                DispatchQueue.main.async {
                    removePaperAlert.dismiss(animated: true, completion: nil)
                    
                    if !isHoldArray[index] || index == isHoldArray.count - 1 {
                        return
                    }
                    
                    self.present(removePaperAlert, animated: true, completion: nil)
                }
            },
                                                        completionHandler:  { (communicationResult: CommunicationResult) in
                DispatchQueue.main.async {
                    removePaperAlert.dismiss(animated: true, completion: nil)
                    
                    self.showSimpleAlert(title: "Communication Result",
                                         message: Communication.getCommunicationResultMessage(communicationResult),
                                         buttonTitle: "OK",
                                         buttonStyle: .cancel)
                    
                    self.setBlind(false)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "Always hold"
        case 1:
            cell.textLabel!.text = "Hold before printing the last page"
        case 2:
            cell.textLabel!.text = "Do not hold"
        default:
            fatalError()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: UITableViewCell? = tableView.cellForRow(at: indexPath)

        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark;
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell: UITableViewCell? = tableView.cellForRow(at: indexPath)

        cell?.accessoryType = UITableViewCell.AccessoryType.none;
    }
    
    @IBAction func printButtonTouchUpInside(_ sender: Any) {
        self.print()
    }
    
}
