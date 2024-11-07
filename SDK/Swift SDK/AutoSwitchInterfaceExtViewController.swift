//
//  AutoInterfaceSelectExtViewController.swift
//  Swift SDK
//
//  Created by 上田　雄磨 on 2020/01/10.
//  Copyright © 2020 Star Micronics. All rights reserved.
//

import UIKit

class AutoSwitchInterfaceExtViewController: CommonLabelViewController, StarIoExtManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    enum CellParamIndex: Int {
        case barcodeData = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var printButton: UIButton!
    
    var cellArray: NSMutableArray!
    
    var starIoExtManager: StarIoExtManager!
    
    var showConfirm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.printButton.isEnabled           = true
        self.printButton.backgroundColor   = UIColor.cyan
        self.printButton.layer.borderColor = UIColor.blue.cgColor
        self.printButton.layer.borderWidth = 1.0
        
        self.appendRefreshButton(#selector(AutoSwitchInterfaceExtViewController.refreshBarcodeReader))
        
        self.cellArray = NSMutableArray()
        
        // Specifying AutoSwitch: for portName allows you to automatically select the interface for connecting to the printer.
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.withBarcodeReader,
                                             portName: "AutoSwitch:",
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)
        
        self.starIoExtManager.cashDrawerOpenActiveHigh = AppDelegate.getCashDrawerOpenActiveHigh()
        
        self.starIoExtManager.delegate = self
    }
    
    func print() {
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(LanguageIndex.english, paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        let commands = PrinterFunctions.createRasterReceiptData(AppDelegate.getEmulation(), localizeReceipts: localizeReceipts)
        
        self.setBlind(true)
        
        self.starIoExtManager.lock.lock()
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                _ = Communication.sendCommands(commands,
                                               port: self.starIoExtManager.port,
                                               completionHandler: { (communicationResult: CommunicationResult) in
                    DispatchQueue.main.async {
                        var portName = "";
                        
                        if self.starIoExtManager.port != nil {
                            portName = self.starIoExtManager.port.portName()
                        } else {
                            portName = "nil"
                        }
                        
                        self.showSimpleAlert(title: "Communication Result",
                                             message: Communication.getCommunicationResultMessage(communicationResult) + "\nPort Name: " + portName,
                                             buttonTitle: "OK",
                                             buttonStyle: .cancel)
                        
                        self.starIoExtManager.lock.unlock()
                        
                        self.setBlind(false)
                    }
                })
            }
        }
    }
    
    func connect() {
        self.setBlind(true)
        
        self.starIoExtManager.disconnect()
        self.starIoExtManager.connectAsync()
    }
    
    nonisolated func manager(_ manager: StarIoExtManager, didConnectPort portName: String) {
        Task{
            await self.setBlind(false)
            
            await self.tableView.reloadData()
        }
    }

    nonisolated func manager(_ manager: StarIoExtManager, didFailToConnectPort portName: String, error: Error?) {
        Task{
            if let error = error as NSError? {
                await self.showSimpleAlert(title: "Communication Result",
                                     message: Communication.getCommunicationResultMessage(CommunicationResult.init(.errorOpenPort, error.code)),
                                     buttonTitle: "OK",
                                     buttonStyle: .cancel,
                                     completion: { _ in
                    Task {
                        await self.setCommentLabel(text: """
                                            \(error.localizedDescription)
                                            
                                            Check the device. (Power and Bluetooth pairing)
                                            Then touch up the Refresh button.
                                            """,
                                             color: UIColor.red)
                                          
                        await self.setBlind(false)
                    }
                })
            }
            
            await self.tableView.reloadData()
        }
    }
    
    func addListBarcodeData(_ lines: [String]){
        for bcrStr in lines {
            if self.cellArray.count > 30 {     // Max.30Line
                self.cellArray.removeObject(at: 0)
                
                self.tableView.reloadData()
            }
            
            self.cellArray.add([bcrStr])
        }
        
        self.tableView.reloadData()
        
        let indexPath: IndexPath = IndexPath(row: self.cellArray.count - 1, section: 0)
        
        self.tableView.selectRow(at: indexPath, animated:true, scrollPosition: UITableView.ScrollPosition.bottom)
        
        self.tableView.deselectRow(at: indexPath, animated:true)
    }
    
    nonisolated func didBarcodeDataReceive(_ manager: StarIoExtManager!, data: Data!) {
        NSLog("%@", MakePrettyFunction())
        
        guard let str = String(data: data, encoding: .ascii) else {
            return
        }
        
        Task {
            var lines = [String]()
            
            str.enumerateLines { (line, stop) -> () in
                lines.append(line)
            }
            await self.addListBarcodeData(lines)
        }
    }
    
    nonisolated func didPrinterImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Printer Impossible.", color: UIColor.red)
        }
    }
    
    nonisolated func didPrinterOnline(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Printer Online.", color: UIColor.blue)
        }
    }
    
    nonisolated func didPrinterOffline(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
//            await self.setCommentLabel(text: "Printer Offline.", color: UIColor.red)
        }
    }
    
    nonisolated func didPrinterPaperReady(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
//            await self.setCommentLabel(text: "Printer Paper Ready.", color: UIColor.blue)
        }
    }
    
    nonisolated func didPrinterPaperNearEmpty(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Printer Paper Near Empty.", color: UIColor.orange)
        }
    }
    
    nonisolated func didPrinterPaperEmpty(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Printer Paper Empty.", color: UIColor.red)
        }
    }
    
    nonisolated func didPrinterCoverOpen(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Printer Cover Open.", color: UIColor.red)
        }
    }
    
    nonisolated func didPrinterCoverClose(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
//            await self.setCommentLabel(text: "Printer Cover Close.", color: UIColor.blue)
        }
    }
    
    nonisolated func didCashDrawerOpen(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Cash Drawer Open.", color: UIColor.magenta)
        }
    }
    
    nonisolated func didCashDrawerClose(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Cash Drawer Close.", color: UIColor.blue)
        }
    }
    
    nonisolated func didBarcodeReaderImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Barcode Reader Impossible.", color: UIColor.red)
        }
    }
    
    nonisolated func didBarcodeReaderConnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Barcode Reader Connect.", color: UIColor.blue)
        }
    }
    
    nonisolated func didBarcodeReaderDisconnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Barcode Reader Disconnect.", color: UIColor.red)
        }
    }
    
    nonisolated func didAccessoryConnectSuccess(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Accessory Connect Success.", color: UIColor.blue)
        }
    }
    
    nonisolated func didAccessoryConnectFailure(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Accessory Connect Failure.", color: UIColor.red)
        }
    }
    
    nonisolated func didAccessoryDisconnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
            await self.setCommentLabel(text: "Accessory Disconnect.", color: UIColor.red)
        }
    }
    
    nonisolated func didStatusUpdate(_ manager: StarIoExtManager!, status: String!) {
        NSLog("%@", MakePrettyFunction())
        
        Task {
//            await self.setCommentLabel(text: status, color: UIColor.green)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AutoSwitchInterfaceExtViewController.applicationWillResignActive), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AutoSwitchInterfaceExtViewController.applicationDidBecomeActive),  name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)

        if !showConfirm {
            let alert = UIAlertController(title: "How to test AutoSwitch Interface function",
                                          message: "Step 1: Perform Bluetooth pairing and also connect to LAN to take advantage of the AutoSwitch Interface feature.\n\n" +
                                                   "Step 2: Connect to the printer via USB and press the OK button.\n\n" +
                                                   "Step 3: Disconnect the USB cable. You can automatically connect to a printer via Bluetooth or LAN interface and monitoring printer.\n\n" +
                                                   "Step 4: Reconnect to the printer via USB or Bluetooth. Printer is automatically connected via USB or Bluetooth.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                 self.showConfirm = true
                 self.connect()
             }))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            self.connect()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.starIoExtManager.disconnect()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
    }
    
    @objc func applicationDidBecomeActive() {
        self.beginAnimationCommantLabel()
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.refreshBarcodeReader()
            }
        }
    }
    
    @objc func applicationWillResignActive() {
        self.starIoExtManager.disconnect()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellParam: [String] = self.cellArray[indexPath.row] as! [String]
        
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            cell.textLabel!.text = cellParam[CellParamIndex.barcodeData.rawValue]
            cell.detailTextLabel!.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contents"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func refreshBarcodeReader() {
        self.cellArray.removeAllObjects()
        
        self.connect()
    }
    
    @IBAction func printButtonTouchUpInside(_ sender: Any) {
        print()
    }
}
