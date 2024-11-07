//
//  BarcodeReaderExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class BarcodeReaderExtViewController: CommonLabelViewController, StarIoExtManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    enum CellParamIndex: Int {
        case barcodeData = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellArray: NSMutableArray!
    
    var starIoExtManager: StarIoExtManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.appendRefreshButton(#selector(BarcodeReaderExtViewController.refreshBarcodeReader))
        
        self.cellArray = NSMutableArray()
        
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.onlyBarcodeReader,
                                             portName: AppDelegate.getPortName(),
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)                                      // 10000mS!!!
        
        self.starIoExtManager.cashDrawerOpenActiveHigh = AppDelegate.getCashDrawerOpenActiveHigh()
        
        self.starIoExtManager.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BarcodeReaderExtViewController.applicationWillResignActive), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BarcodeReaderExtViewController.applicationDidBecomeActive),  name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
//              self.refreshBarcodeReader()
                
                self.setBlind(true)
                
                defer {
                    self.setBlind(false)
                }
                
                self.starIoExtManager.disconnect()
                
                if self.starIoExtManager.connect() == false {
                    self.showSimpleAlert(title: "Communication Result",
                                         message: "Fail to openPort",
                                         buttonTitle: "OK",
                                         buttonStyle: .default,
                                         completion: { _ in
                        self.setCommentLabel(text: """
                                            Check the device. (Power and Bluetooth pairing)
                                            Then touch up the Refresh button.
                                            """,
                                        color: UIColor.red)
                    })
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.starIoExtManager.disconnect()
            }
        }
        
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
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.starIoExtManager.disconnect()
            }
        }
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
        
//      var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            cell      .textLabel!.text = cellParam[CellParamIndex.barcodeData.rawValue]
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
        self.setBlind(true)
        
        defer {
            self.setBlind(false)
        }
        
        self.cellArray.removeAllObjects()
        
        self.starIoExtManager.disconnect()
        
        if self.starIoExtManager.connect() == false {
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to openPort",
                                 buttonTitle: "OK",
                                 buttonStyle: .default,
                                 completion: { _ in
                self.setCommentLabel(text: """
                                    Check the device. (Power and Bluetooth pairing)
                                    Then touch up the Refresh button.
                                    """,
                                color: UIColor.red)
            })
        }
        
        self.tableView.reloadData()
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
}
