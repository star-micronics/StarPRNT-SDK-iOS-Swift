//
//  AllReceiptsExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class AllReceiptsExtViewController: CommonViewController, StarIoExtManagerDelegate {
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var printButton: UIButton!
    
    var starIoExtManager: StarIoExtManager!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
        self.printButton.isEnabled           = true
        self.printButton.backgroundColor   = UIColor.cyan
        self.printButton.layer.borderColor = UIColor.blue.cgColor
        self.printButton.layer.borderWidth = 1.0
        
        self.appendRefreshButton(#selector(AllReceiptsExtViewController.refreshPrinter))
        
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.standard,
                                             portName: AppDelegate.getPortName(),
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)                             // 10000mS!!!
        
        self.starIoExtManager.cashDrawerOpenActiveHigh = AppDelegate.getCashDrawerOpenActiveHigh()
        
        self.starIoExtManager.delegate = self
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AllReceiptsExtViewController.applicationWillResignActive), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AllReceiptsExtViewController.applicationDidBecomeActive),  name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
        
//      self.refreshPrinter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.refreshPrinter()
                
                if self.didAppear == false {
                    if self.starIoExtManager.port != nil {
                        self.printButton.sendActions(for: UIControl.Event.touchUpInside)
                    }
                    
                    self.didAppear = true
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        GlobalQueueManager.shared.serialQueue.async {
            self.starIoExtManager.disconnect()
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
    }
    
    @objc func applicationDidBecomeActive() {
        self.beginAnimationCommantLabel()
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.refreshPrinter()
            }
        }
    }
    
    @objc func applicationWillResignActive() {
        GlobalQueueManager.shared.serialQueue.async {
            self.starIoExtManager.disconnect()
        }
    }
    
    @IBAction func touchUpInsidePrintButton(_ sender: UIButton) {
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let width: Int = AppDelegate.getSelectedPaperSize().rawValue
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        let completionUpload: (Int, Error?) -> Void = {(statusCode, error) -> Void in
            let prompt: String

            if let error = error as NSError? {
                prompt = String(format: "%@", error)
            }
            else {
                prompt = String(format: "Status Code : %ld", statusCode)
            }
            
            NSLog("%@", prompt)
            
            self.navigationItem.prompt = prompt
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.navigationItem.prompt = nil
            })
        }
        
        let commands: Data?
        
        var receipt: Bool = true
        var info:    Bool = true
        var qrCode:  Bool = true
        
        let allReceiptsSettings: Int = AppDelegate.getAllReceiptsSettings()
        
        if (allReceiptsSettings & 0x00000001) == 0x00000000 {
            receipt = false
        }
        
        if (allReceiptsSettings & 0x00000002) == 0x00000000 {
            info = false
        }
        
        if (allReceiptsSettings & 0x00000004) == 0x00000000 {
            qrCode = false
        }
        
        switch AppDelegate.getSelectedIndex() {
        case 0 :
            commands = AllReceiptsFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false, width: width, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
        case 1 :
            commands = AllReceiptsFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true,  width: width, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
        case 2 :
            commands = AllReceiptsFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
        case 3 :
            commands = AllReceiptsFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
//      case 4  :
        default :
            commands = AllReceiptsFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false, receipt: receipt, info: info, qrCode: qrCode, completion: completionUpload)
        }
        
        if commands != nil {
            self.blind = true
            
            self.starIoExtManager.lock.lock()
            
            GlobalQueueManager.shared.serialQueue.async {
                _ = Communication.sendCommands(commands,
                                               port: self.starIoExtManager.port,
                                               completionHandler: { (communicationResult: CommunicationResult) in
                    DispatchQueue.main.async {
                        self.showSimpleAlert(title: "Communication Result",
                                             message: Communication.getCommunicationResultMessage(communicationResult),
                                             buttonTitle: "OK",
                                             buttonStyle: .cancel)
                        
                        self.starIoExtManager.lock.unlock()
                        
                        self.blind = false
                    }
                })
            }
        }
    }
    
    @objc func refreshPrinter() {
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.starIoExtManager.disconnect()
        
        if self.starIoExtManager.connect() == false {
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to openPort",
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel,
                                 completion: { _ in
                self.commentLabel.text = """
                Check the device. (Power and Bluetooth pairing)
                Then touch up the Refresh button.
                """
                
                self.commentLabel.textColor = UIColor.red
                
                self.beginAnimationCommantLabel()
            })
        }
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
        
        SMCSAllReceipts.updateStatus(status, completion: {
            (statusCode, error) -> Void in
            let prompt: String
            
            if let error = error as NSError? {
                prompt = String(format: "%@", error)
            }
            else {
                prompt = String(format: "Status Code : %ld", statusCode)
            }
            
            NSLog("%@", prompt)
            
            self.navigationItem.prompt = prompt
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.navigationItem.prompt = nil
            })
        })
    }
    
    fileprivate func beginAnimationCommantLabel() {
        UIView.beginAnimations(nil, context: nil)
        
        self.commentLabel.alpha = 0.0
        
        UIView.setAnimationDelay             (0.0)                             // 0mS!!!
        UIView.setAnimationDuration          (0.6)                             // 600mS!!!
        UIView.setAnimationRepeatCount       (Float(UINT32_MAX))
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationCurve             (UIView.AnimationCurve.easeIn)
        
        self.commentLabel.alpha = 1.0
        
        UIView.commitAnimations()
    }
}
