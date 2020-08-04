//
//  DisplayViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class DisplayViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath: IndexPath!
    
    var internationalType: SDCBInternationalType!
    var codePageType:      SDCBCodePageType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.selectedIndexPath = nil
        
        self.internationalType = SDCBInternationalType.USA
        self.codePageType      = SDCBCodePageType     .CP437
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0  : cell.textLabel!.text = "Check Status"
                case 1  : cell.textLabel!.text = "Text"
                case 2  : cell.textLabel!.text = "Graphic"
                case 3  : cell.textLabel!.text = "Back Light (Turn On / Off)"
                case 4  : cell.textLabel!.text = "Cursor"
                case 5  : cell.textLabel!.text = "Contrast"
                case 6  : cell.textLabel!.text = "Character Set (International)"
                case 7  : cell.textLabel!.text = "Character Set (Code Page)"
                default : cell.textLabel!.text = "User Defined Character"            // 8
                }
            }
            else {
                cell.textLabel!.text = "Sample"
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
            title = "Contents"
        }
        else {
            title = "Like a StarIoExtManager Sample"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedIndexPath = indexPath
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.blind = true
                
                defer {
                    self.blind = false
                }
                
                var port : SMPort
                
                let portName = AppDelegate.getPortName()
                
                do {
                    // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
                    // (Refer Readme for details)
//                  port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: 10000)
                    port = try SMPort.getPort(portName: portName, portSettings: AppDelegate.getPortSettings(), ioTimeoutMillis: 10000)
                }
                catch let error as NSError {
                    self.showSimpleAlert(title: "Communication Result",
                                         message: Communication.getCommunicationResultMessage(CommunicationResult.init(.errorOpenPort, error.code)),
                                         buttonTitle: "OK",
                                         buttonStyle: .cancel)
                    return
                }
                
                defer {
                    SMPort.release(port)
                }
                
                // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
                // (Refer Readme for details)
                if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                    Thread.sleep(forTimeInterval: 0.2)
                }
                
                let parser: ISCPConnectParser = StarIoExt.createDisplayConnectParser(StarIoExtDisplayModel.SCD222)
                
                _ = Communication.parseDoNotCheckCondition(parser,
                                                           port: port,
                                                           completionHandler: { (communicationResult: CommunicationResult) in
                    if communicationResult.result == .success {
                        if parser.connect() == true {
                            self.showSimpleAlert(title: "Check Status",
                                                 message: "Display Connect.",
                                                 buttonTitle: "OK",
                                                 buttonStyle: .cancel)
                        }
                        else {
                            self.showSimpleAlert(title: "Check Status",
                                                 message: "Display Disconnect.",
                                                 buttonTitle: "OK",
                                                 buttonStyle: .cancel)
                        }
                    }
                    else {
                        self.showSimpleAlert(title: "Communication Result",
                                             message: Communication.getCommunicationResultMessage(communicationResult),
                                             buttonTitle: "OK",
                                             buttonStyle: .cancel)
                    }
                })
            }
            else {
                let builder: ISDCBBuilder = StarIoExt.createDisplayCommandBuilder(StarIoExtDisplayModel.SCD222)
                
                switch indexPath.row {
                case 1 :
                    let selections: [String] = ["Pattern 1", "Pattern 2", "Pattern 3",
                                                "Pattern 4", "Pattern 5", "Pattern 6"]
                    
                    self.showAlert(title: "Select Text",
                                   buttonTitles: selections,
                                   handler: { selectedButtonIndex in
                                    DisplayFunctions.appendClearScreen(builder: builder)
                                    
                                    DisplayFunctions.appendCharacterSet(builder: builder,
                                                                        internationalType: self.internationalType,
                                                                        codePageType: self.codePageType)
                                    
                                    DisplayFunctions.appendTextPattern(builder: builder,
                                                                       number: selectedButtonIndex - 1)
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })
                case 2 :
                    let selections: [String] = ["Pattern 1", "Pattern 2"]
                    
                    self.showAlert(title: "Select Graphic",
                                   buttonTitles: selections,
                                   handler: { selectedButtonIndex in
                                    DisplayFunctions.appendClearScreen(builder: builder)
                                    
                                    DisplayFunctions.appendGraphicPattern(builder: builder,
                                                                          number: selectedButtonIndex - 1)
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })
                case 3 :
                    self.showAlert(title: "Select Turn On / Off",
                                   buttonTitles: ["Turn On", "Turn Off"],
                                   handler: { selectedButtonIndex in
                                    switch selectedButtonIndex - 1 {
                                    case 0:
                                        DisplayFunctions.appendTurnOn(builder: builder, turnOn: true)
                                    case 1:
                                        DisplayFunctions.appendTurnOn(builder: builder, turnOn: false)
                                    default:
                                        preconditionFailure()
                                    }
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })
                    
                case 4 :
                    self.showAlert(title: "Select Cursor",
                                   buttonTitles: ["Off", "Blink", "On"],
                                   handler: { selectedButtonIndex in
                                    DisplayFunctions.appendClearScreen(builder: builder)
                                    
                                    let cursorMode: SDCBCursorMode = SDCBCursorMode(rawValue: selectedButtonIndex - 1)!
                                    DisplayFunctions.appendCursorMode(builder: builder,
                                                                      cursorMode: cursorMode)
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })
                    
                case 5 :
                    let buttonTitles = ["Contrast -3", "Contrast -2", "Contrast -1",
                                        "Default", "Contrast +1", "Contrast +2",
                                        "Contrast +3"]
                    
                    self.showAlert(title: "Select Contrast",
                                   buttonTitles: buttonTitles,
                                   handler: { selectedButtonIndex in
                                    let contrastMode =  SDCBContrastMode(rawValue: selectedButtonIndex - 1)!
                                    
                                    DisplayFunctions.appendContrastMode(builder: builder,
                                                                        contrastMode: contrastMode)
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })
                case 6 :
                    let buttonTitles = ["USA", "France", "Germany", "UK", "Denmark",
                                        "Sweden", "Italy", "Spain", "Japan", "Norway",
                                        "Denmark 2", "Spain 2", "Latin America",
                                        "Korea"]
                    
                    self.showAlert(title: "Select Character Set (International)",
                                   buttonTitles: buttonTitles,
                                   handler: { selectedButtonIndex in
                                    self.internationalType = SDCBInternationalType(rawValue: selectedButtonIndex - 1)!
                                    
                                    DisplayFunctions.appendClearScreen(builder: builder)
                                    
                                    DisplayFunctions.appendCharacterSet(builder: builder,
                                                                        internationalType: self.internationalType,
                                                                        codePageType: self.codePageType)
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })
                case 7 :
                    let buttonTitles = ["Code Page 437", "Katakana", "Code Page 850",
                                        "Code Page 860", "Code Page 863", "Code Page 865",
                                        "Code Page 1252", "Code Page 866", "Code Page 852",
                                        "Code Page 858", "Japanese", "Simplified Chinese",
                                        "Traditional Chinese", "Hangul"]
                    
                    self.showAlert(title: "Select Character Set (Code Page)",
                                   buttonTitles: buttonTitles,
                                   handler: { selectedButtonIndex in
                                    self.codePageType = SDCBCodePageType(rawValue: selectedButtonIndex - 1)!
                                    
                                    DisplayFunctions.appendClearScreen(builder: builder)
                                    
                                    DisplayFunctions.appendCharacterSet(builder: builder,
                                                                        internationalType: self.internationalType,
                                                                        codePageType: self.codePageType)
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })

                case 8  :
                    self.showAlert(title: "Select User Defined Character",
                                   buttonTitles: ["Set", "Reset"],
                                   handler: { selectedButtonIndex in
                                    DisplayFunctions.appendClearScreen(builder: builder)
                                    
                                    switch selectedButtonIndex - 1 {
                                    case 0  : DisplayFunctions.appendUserDefinedCharacter(builder: builder,
                                                                                          set: true)
                                    default : DisplayFunctions.appendUserDefinedCharacter(builder: builder,
                                                                                          set: false)     // 1
                                    }
                                    
                                    let commands: Data = builder.passThroughCommands.copy() as! Data
                                    
                                    self.sendCommandsToPrinter(commands: commands)
                    })

                default :
                    fatalError()
                }
            }
        }
        else {
            AppDelegate.setSelectedIndex(indexPath.row)
            
            self.performSegue(withIdentifier: "PushDisplayExtViewController", sender: nil)
        }
    }
    
    func sendCommandsToPrinter(commands: Data) {
        self.blind = true
        
        defer {
            self.blind = false
        }

        var port : SMPort
        
        let portName = AppDelegate.getPortName()
        
        do {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: 10000)
            port = try SMPort.getPort(portName: portName, portSettings: AppDelegate.getPortSettings(), ioTimeoutMillis: 10000)
        }
        catch let error as NSError {
            self.showSimpleAlert(title: "Communication Result",
                                 message: Communication.getCommunicationResultMessage(CommunicationResult.init(.errorOpenPort, error.code)),
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel)
            return
        }
        
        defer {
            SMPort.release(port)
        }
        
        // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
        // (Refer Readme for details)
        if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
            Thread.sleep(forTimeInterval: 0.2)
        }
        
        let parser: ISCPConnectParser = StarIoExt.createDisplayConnectParser(StarIoExtDisplayModel.SCD222)
        
        _ = Communication.parseDoNotCheckCondition(parser,
                                                   port: port,
                                                   completionHandler: { (communicationResult: CommunicationResult) in
                                                    if communicationResult.result == .success {
                                                        if parser.connect() == true {
                                                            _ = Communication.sendCommandsDoNotCheckCondition(commands,
                                                                                                              port: port,
                                                                                                              completionHandler: { (communicationResult: CommunicationResult) in
                                                                                                                if communicationResult.result != .success {
                                                                                                                    self.showSimpleAlert(title: "Communication Result",
                                                                                                                                         message: Communication.getCommunicationResultMessage(communicationResult),
                                                                                                                                         buttonTitle: "OK",
                                                                                                                                         buttonStyle: .cancel)
                                                                                                                }
                                                            })
                                                        }
                                                        else {
                                                            self.showSimpleAlert(title: "Check Status",
                                                                                 message: "Display Disconnect.",
                                                                                 buttonTitle: "OK",
                                                                                 buttonStyle: .cancel)
                                                        }
                                                    }
                                                    else {
                                                        self.showSimpleAlert(title: "Communication Result",
                                                                             message: Communication.getCommunicationResultMessage(communicationResult),
                                                                             buttonTitle: "OK",
                                                                             buttonStyle: .cancel)
                                                    }
        })
    }
}


