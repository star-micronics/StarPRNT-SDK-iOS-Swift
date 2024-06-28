//
//  AutoInterfaceSelectExtViewController.swift
//  Swift SDK
//
//  Created by 上田　雄磨 on 2020/01/10.
//  Copyright © 2020 Star Micronics. All rights reserved.
//

import UIKit

class AutoSwitchInterfaceExtViewController: CommonViewController, StarIoExtManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    enum CellParamIndex: Int {
        case barcodeData = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var printButton: UIButton!
    
    var cellArray: NSMutableArray!
    
    var starIoExtManager: StarIoExtManager!
    
    var showConfirm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
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
        
        self.blind = true

        self.starIoExtManager.lock.lock()
        
        GlobalQueueManager.shared.serialQueue.async {
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
                    
                    self.blind = false
                }
            })
        }
    }
    
    func connect() {
        self.blind = true
        
        self.starIoExtManager.disconnect()
        self.starIoExtManager.connectAsync()
    }
    
    func manager(_ manager: StarIoExtManager, didConnectPort portName: String) {
        self.blind = false
        
        self.tableView.reloadData()
    }

    func manager(_ manager: StarIoExtManager, didFailToConnectPort portName: String, error: Error?) {
        if let error = error as NSError? {
            self.showSimpleAlert(title: "Communication Result",
                                 message: Communication.getCommunicationResultMessage(CommunicationResult.init(.errorOpenPort, error.code)),
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel,
                                 completion: { _ in
                                    self.commentLabel.text = """
                                    \(error.localizedDescription)
                                    
                                    Check the device. (Power and Bluetooth pairing)
                                    Then touch up the Refresh button.
                                    """
                                    
                                    self.commentLabel.textColor = UIColor.red
                                    
                                    self.beginAnimationCommantLabel()

                                    self.blind = false
            })
        }
        
        self.tableView.reloadData()
    }
    
    func didBarcodeDataReceive(_ manager: StarIoExtManager!, data: Data!) {
        NSLog("%@", MakePrettyFunction())
        
        guard let str = String(data: data, encoding: .ascii) else {
            return
        }
        
        var lines = [String]()
        
        str.enumerateLines { (line, stop) -> () in
            lines.append(line)
        }
        
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
    
    func didPrinterImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Impossible."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterOnline(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Online."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterOffline(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Offline."
//
//      self.commentLabel.textColor = UIColor.red
//
//      self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperReady(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Paper Ready."
//
//      self.commentLabel.textColor = UIColor.blue
//
//      self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperNearEmpty(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Paper Near Empty."
        
        self.commentLabel.textColor = UIColor.orange
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperEmpty(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Paper Empty."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterCoverOpen(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Cover Open."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterCoverClose(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Cover Close."
//
//      self.commentLabel.textColor = UIColor.blue
//
//      self.beginAnimationCommantLabel()
    }
    
    func didCashDrawerOpen(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Cash Drawer Open."
        
//      self.commentLabel.textColor = UIColor.red
        self.commentLabel.textColor = UIColor.magenta
        
        self.beginAnimationCommantLabel()
    }
    
    func didCashDrawerClose(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Cash Drawer Close."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Impossible."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderConnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Connect."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderDisconnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Disconnect."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryConnectSuccess(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Connect Success."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryConnectFailure(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Connect Failure."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryDisconnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Disconnect."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didStatusUpdate(_ manager: StarIoExtManager!, status: String!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = status
//
//      self.commentLabel.textColor = UIColor.green
//
//      self.beginAnimationCommantLabel()
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
    
    fileprivate func beginAnimationCommantLabel() {
        self.commentLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       options: [.repeat, .autoreverse, .curveEaseIn],
                       animations: {
            self.commentLabel.alpha = 1.0
        })
    }
    
    @IBAction func printButtonTouchUpInside(_ sender: Any) {
        print()
    }
}
