//
//  SearchPortViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class SearchPortViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    enum CellParamIndex: Int {
        case portName = 0
        case modelName
        case macAddress
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellArray: NSMutableArray!
    
    var selectedIndexPath: IndexPath!
    
    var didAppear: Bool!
    
    var portName:     String!
    var portSettings: String!
    var modelName:    String!
    var macAddress:   String!
    var paperSizeIndex: PaperSizeIndex? = nil
    
    var emulation: StarIoExtEmulation!
    
    var selectedModelIndex: ModelIndex?
    
    var selectedPrinterIndex: Int = 0
    
    var currentSetting: PrinterSetting? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appendRefreshButton(#selector(SearchPortViewController.refreshPortInfo))
        
        self.cellArray = NSMutableArray()
        
        self.selectedIndexPath = nil
        
        self.didAppear = false
        
        self.currentSetting = AppDelegate.settingManager.settings[selectedPrinterIndex]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didAppear == false {
            self.refreshPortInfo()
            
            self.didAppear = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleSubtitle"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let cellParam: [String] = self.cellArray[indexPath.row] as! [String]
            
            cell.textLabel!.text = cellParam[CellParamIndex.modelName.rawValue]
            
            if cellParam[CellParamIndex.macAddress.rawValue] == "" {
                cell.detailTextLabel!.text = cellParam[CellParamIndex.portName.rawValue]
            }
            else {
                cell.detailTextLabel!.text = "\(cellParam[CellParamIndex.portName.rawValue]) (\(cellParam[CellParamIndex.macAddress.rawValue]))"
            }
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCell.AccessoryType.none
            
            if cellParam[CellParamIndex.portName.rawValue] == AppDelegate.settingManager.settings[self.selectedPrinterIndex]?.portName {
                cell.accessoryType = .checkmark
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell: UITableViewCell!
        
        if self.selectedIndexPath != nil {
            cell = tableView.cellForRow(at: self.selectedIndexPath)
            
            if cell != nil {
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
        
        cell = tableView.cellForRow(at: indexPath)!
        
        _ = tableView.visibleCells.map{ $0.accessoryType = .none }
        cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        self.selectedIndexPath = indexPath
        
        let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
        
        let modelName:  String = cellParam[CellParamIndex.modelName.rawValue]
        
        let modelIndex = ModelCapability.modelIndex(of: modelName)
        
        if let modelIndex = modelIndex {
            self.selectedModelIndex = modelIndex
            
            guard let title = ModelCapability.title(at: modelIndex) else {
                fatalError()
            }
            
            let alert = UIAlertController(title: "Confirm.",
                                          message: "Is your printer \(title)?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
                self.didConfirmModel(buttonIndex: 1)
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { _ in
                self.didConfirmModel(buttonIndex: 0)
            }))

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Confirm.",
                                          message: "What is your printer?",
                                          preferredStyle: .alert)
            
            for i: Int in 0..<ModelCapability.modelIndexCount() {
                let modelIndex: ModelIndex = ModelCapability.modelIndex(at: i)
                let title: String? = ModelCapability.title(at: modelIndex)
                
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
                    self.didSelectModel(buttonIndex: i + 1)
                }))
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func refreshPortInfo() {
        let alert = UIAlertController(title: "Select Interface.",
                                      message: nil,
                                      preferredStyle: .alert)
        let buttonTitles = ["LAN", "Bluetooth", "Bluetooth Low Energy", "USB", "All"]
        for i in 0..<buttonTitles.count {
            alert.addAction(UIAlertAction(title: buttonTitles[i], style: .default, handler: { _ in
                self.didSelectRefreshPortInterfaceType(buttonIndex: i + 1)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Manual", style: .default, handler: { _ in
            self.didSelectManualInput()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.navigationController!.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func modelSelect1AlertClickedButtonAt(buttonIndex: Int?) {
        if buttonIndex != 0 {   // Not cancel
            let modelIndex = ModelCapability.modelIndex(at: buttonIndex! - 1)
            
            self.modelName    = ModelCapability.title(at: modelIndex)
            self.macAddress   = self.portSettings                                        // for display.
            self.emulation    = ModelCapability.emulation(at: modelIndex)
            self.selectedModelIndex = modelIndex
            
            switch self.emulation {
            case .escPos?:
                self.paperSizeIndex = .escPosThreeInch
            case .starDotImpact?:
                self.paperSizeIndex = .dotImpactThreeInch
            default:
                self.paperSizeIndex = nil
            }
            
            if (selectedPrinterIndex != 0) {
                self.paperSizeIndex = AppDelegate.settingManager.settings[0]?.selectedPaperSize
            }
            
            if self.paperSizeIndex == nil {
                self.showAlert(title: "Select paper size.",
                               buttonTitles: ["2\" (384dots)", "3\" (576dots)", "4\" (832dots)"],
                               handler: { selectedButtonIndex in
                                self.didSelectPaperSize(buttonIndex: selectedButtonIndex)
                })
                
            } else {
                if ModelCapability.supportedExternalCashDrawer(at: modelIndex) == true {
                    self.showAlert(title: "Select CashDrawer Open Status.",
                                   buttonTitles: ["High when Open", "Low when Open"],
                                   handler: { selectedButtonIndex in
                                    self.didSelectCashDrawerOpenActiveHigh(buttonIndex: selectedButtonIndex)
                    })
                }
                else {
                    self.saveParams(portName: self.portName,
                                    portSettings: self.portSettings,
                                    modelName: self.modelName,
                                    macAddress: self.macAddress,
                                    emulation: self.emulation,
                                    isCashDrawerOpenActiveHigh: true,
                                    modelIndex: self.selectedModelIndex,
                                    paperSizeIndex: self.paperSizeIndex)
                    
                    self.navigationController!.popViewController(animated: true)
                }
            }
        }
    }
    
    fileprivate func saveParams(portName: String,
                                portSettings: String,
                                modelName: String,
                                macAddress: String,
                                emulation: StarIoExtEmulation,
                                isCashDrawerOpenActiveHigh: Bool,
                                modelIndex: ModelIndex?,
                                paperSizeIndex: PaperSizeIndex?) {
        if let modelIndex = modelIndex,
            let paperSizeIndex = paperSizeIndex {
            let allReceiptsSetting = AppDelegate.settingManager.settings[selectedPrinterIndex]?.allReceiptsSettings ?? 0x07
            
            AppDelegate.settingManager.settings[selectedPrinterIndex] = PrinterSetting(portName: portName,
                                                                                       portSettings: portSettings,
                                                                                       macAddress: macAddress,
                                                                                       modelName: modelName,
                                                                                       emulation: emulation,
                                                                                       cashDrawerOpenActiveHigh: isCashDrawerOpenActiveHigh,
                                                                                       allReceiptsSettings: allReceiptsSetting,
                                                                                       selectedPaperSize: paperSizeIndex,
                                                                                       selectedModelIndex: modelIndex)
            
            AppDelegate.settingManager.save()
        } else {
            fatalError()
        }
    }
    
    fileprivate func didSelectCashDrawerOpenActiveHigh(buttonIndex: Int) {
        let isCashDrawerOpenActiveHigh: Bool
        
        if buttonIndex == 1 {     // High when Open
            isCashDrawerOpenActiveHigh = true
        }
        else if buttonIndex == 2 {     // Low when Open
            isCashDrawerOpenActiveHigh = false
        } else {
            fatalError()
        }
        
        self.saveParams(portName: self.portName,
                        portSettings: self.portSettings,
                        modelName: self.modelName,
                        macAddress: self.macAddress,
                        emulation: self.emulation,
                        isCashDrawerOpenActiveHigh: isCashDrawerOpenActiveHigh,
                        modelIndex: self.selectedModelIndex,
                        paperSizeIndex: self.paperSizeIndex)
        
        self.navigationController!.popViewController(animated: true)
    }
    
    fileprivate func didSelectPaperSize(buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            self.paperSizeIndex = .twoInch
        case 2:
            self.paperSizeIndex = .threeInch
        case 3:
            self.paperSizeIndex = .fourInch
        default:
            fatalError()
        }
        
        guard let modelIndex = self.selectedModelIndex else {
            fatalError()
        }
        
        if ModelCapability.supportedExternalCashDrawer(at: modelIndex) == true {
            self.showAlert(title: "Select CashDrawer Open Status.",
                           buttonTitles: ["High when Open", "Low when Open"],
                           handler: { selectedButtonIndex in
                            self.didSelectCashDrawerOpenActiveHigh(buttonIndex: selectedButtonIndex)
            })
        }
        else {
            self.saveParams(portName: self.portName,
                            portSettings: self.portSettings,
                            modelName: self.modelName,
                            macAddress: self.macAddress,
                            emulation: self.emulation,
                            isCashDrawerOpenActiveHigh: true,
                            modelIndex: self.selectedModelIndex,
                            paperSizeIndex: self.paperSizeIndex)
            
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    func didConfirmModel(buttonIndex: Int) {
        if buttonIndex == 1 {     // YES
            let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
            
            self.portName   = cellParam[CellParamIndex.portName  .rawValue]
            self.modelName  = cellParam[CellParamIndex.modelName .rawValue]
            self.macAddress = cellParam[CellParamIndex.macAddress.rawValue]
            
            guard let modelIndex = ModelCapability.modelIndex(of: self.modelName) else {
                fatalError()
            }
            
            self.portSettings = ModelCapability.portSettings(at: modelIndex)
            self.emulation = ModelCapability.emulation(at: modelIndex)
            self.selectedModelIndex = modelIndex
            
            switch emulation {
            case .starDotImpact?:
                self.paperSizeIndex = PaperSizeIndex.dotImpactThreeInch
            case .escPos?:
                self.paperSizeIndex = PaperSizeIndex.escPosThreeInch
            default:
                self.paperSizeIndex = nil
            }
            
            if (selectedPrinterIndex != 0) {
                self.paperSizeIndex = AppDelegate.settingManager.settings[0]?.selectedPaperSize
            }
            
            if self.paperSizeIndex == nil {
                self.showAlert(title: "Select paper size.",
                               buttonTitles: ["2\" (384dots)", "3\" (576dots)", "4\" (832dots)"],
                               handler: { selectedButtonIndex in
                                self.didSelectPaperSize(buttonIndex: selectedButtonIndex)
                })
            } else {
                if ModelCapability.supportedExternalCashDrawer(at: modelIndex) == true {
                    self.showAlert(title: "Select CashDrawer Open Status.",
                                   buttonTitles: ["High when Open", "Low when Open"],
                                   handler: { selectedButtonIndex in
                                    self.didSelectCashDrawerOpenActiveHigh(buttonIndex: selectedButtonIndex)
                    })
                } else {
                    self.saveParams(portName: self.portName,
                                    portSettings: self.portSettings,
                                    modelName: self.modelName,
                                    macAddress: self.macAddress,
                                    emulation: self.emulation,
                                    isCashDrawerOpenActiveHigh: true,
                                    modelIndex: self.selectedModelIndex,
                                    paperSizeIndex: paperSizeIndex)
                    
                    self.navigationController!.popViewController(animated: true)
                }
            }
        }
        else {     // NO
            let alert = UIAlertController(title: "Confirm.",
                                          message: "What is your printer?",
                                          preferredStyle: .alert)
            
            for i: Int in 0..<ModelCapability.modelIndexCount() {
                let modelIndex: ModelIndex = ModelCapability.modelIndex(at: i)
                let title: String? = ModelCapability.title(at: modelIndex)
                
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
                    self.didSelectModel(buttonIndex: i + 1)
                }))
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didSelectModel(buttonIndex: Int) {
        let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
        
        self.portName   = cellParam[CellParamIndex.portName  .rawValue]
        self.modelName  = cellParam[CellParamIndex.modelName .rawValue]
        self.macAddress = cellParam[CellParamIndex.macAddress.rawValue]
        
        let modelIndex: ModelIndex = ModelCapability.modelIndex(at: buttonIndex - 1)
        
        self.portSettings = ModelCapability.portSettings(at: modelIndex)
        self.emulation = ModelCapability.emulation(at: modelIndex)
        self.selectedModelIndex = modelIndex
        
        let supportedExternalCashDrawer = ModelCapability.supportedExternalCashDrawer(at: modelIndex)!
        switch self.emulation {
        case .escPos?:
            self.paperSizeIndex = .escPosThreeInch
        case .starDotImpact?:
            self.paperSizeIndex = .dotImpactThreeInch
        default:
            self.paperSizeIndex = nil
        }
        
        if (selectedPrinterIndex != 0) {
            self.paperSizeIndex = AppDelegate.settingManager.settings[0]?.selectedPaperSize
        }
        
        if self.paperSizeIndex == nil {
            self.showAlert(title: "Select paper size.",
                           buttonTitles: ["2\" (384dots)", "3\" (576dots)", "4\" (832dots)"],
                           handler: { selectedButtonIndex in
                            self.didSelectPaperSize(buttonIndex: selectedButtonIndex)
            })
        } else {
            if supportedExternalCashDrawer == true {
                self.showAlert(title: "Select CashDrawer Open Status.",
                               buttonTitles: ["High when Open", "Low when Open"],
                               handler: { selectedButtonIndex in
                                self.didSelectCashDrawerOpenActiveHigh(buttonIndex: selectedButtonIndex)
                })
            } else {
                self.saveParams(portName: self.portName,
                                portSettings: self.portSettings,
                                modelName: self.modelName,
                                macAddress: self.macAddress,
                                emulation: self.emulation,
                                isCashDrawerOpenActiveHigh: true,
                                modelIndex: self.selectedModelIndex,
                                paperSizeIndex: self.paperSizeIndex)
                
                self.navigationController!.popViewController(animated: true)
            }
        }
    }
    
    func didInputPortName(portName: String) {
        self.portName = portName
        
        if self.portName == "" {
            let alert = UIAlertController(title: "Please enter the port name.",
                                          message: "Fill in the port name.",
                                          preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = self.currentSetting?.portName ?? ""
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                if let newPortName = alert.textFields?.first?.text {
                    self.didInputPortName(portName: newPortName)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.navigationController!.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Please enter the port settings.",
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = self.currentSetting?.portSettings ?? ""
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                if let newPortSettings = alert.textFields?.first?.text {
                    self.didInputPortSettings(portSettings: newPortSettings)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
                self.navigationController!.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didInputPortSettings(portSettings: String) {
        self.portSettings = portSettings
        
        let nestAlertController = UIAlertController(title: "Confirm.",
                                                    message: "What is your printer?",
                                                    preferredStyle: .alert)
        
        let handler = { (action: UIAlertAction!) in
            let buttonIndex = nestAlertController.actions.firstIndex(of: action)
            
            self.modelSelect1AlertClickedButtonAt(buttonIndex: buttonIndex)
        }
        
        nestAlertController.addAction(UIAlertAction(title: "Cancel",
                                                    style: .cancel,
                                                    handler: handler))
        
        for i: Int in 0 ..< ModelCapability.modelIndexCount() {
            let modelIndex: ModelIndex = ModelCapability.modelIndex(at: i)
            let title: String? = ModelCapability.title(at: modelIndex)
            let action: UIAlertAction = UIAlertAction(title: title,
                                                      style: .default,
                                                      handler: handler)
            nestAlertController.addAction(action)
        }
        
        present(nestAlertController, animated: true, completion: nil)
    }
    
    func didSelectRefreshPortInterfaceType(buttonIndex: Int) {
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.cellArray.removeAllObjects()
        
        self.selectedIndexPath = nil
        
        var searchPrinterResult: [PortInfo]? = nil
        
        do {
            switch buttonIndex {
            case 1  :     // LAN
                searchPrinterResult = try SMPort.searchPrinter(target: "TCP:") as? [PortInfo]
            case 2  :     // Bluetooth
                searchPrinterResult = try SMPort.searchPrinter(target: "BT:")  as? [PortInfo]
            case 3  :     // Bluetooth Low Energy
                searchPrinterResult = try SMPort.searchPrinter(target: "BLE:") as? [PortInfo]
            case 4  :     // USB
                searchPrinterResult = try SMPort.searchPrinter(target: "USB:") as? [PortInfo]
//          case 5  :     // All
            default :
                searchPrinterResult = try SMPort.searchPrinter(target: "ALL:") as? [PortInfo]
            }
        }
        catch {
            // do nothing
        }
            
        guard let portInfoArray: [PortInfo] = searchPrinterResult else {
            self.tableView.reloadData()
            return
        }
        
        let portName:   String = currentSetting?.portName ?? ""
        let modelName:  String = currentSetting?.portSettings ?? ""
        let macAddress: String = currentSetting?.macAddress ?? ""
        
        var row: Int = 0
        
        for portInfo: PortInfo in portInfoArray {
            self.cellArray.add([portInfo.portName, portInfo.modelName, portInfo.macAddress])
            
            if portInfo.portName   == portName  &&
                portInfo.modelName  == modelName &&
                portInfo.macAddress == macAddress {
                self.selectedIndexPath = IndexPath(row: row, section: 0)
            }
            
            row += 1
        }
        
        self.tableView.reloadData()
    }
    
    func didSelectManualInput() {
        let alert = UIAlertController(title: "Please enter the port name.",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.currentSetting?.portName ?? ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let portName = alert.textFields?.first?.text {
                self.didInputPortName(portName: portName)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.navigationController!.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
