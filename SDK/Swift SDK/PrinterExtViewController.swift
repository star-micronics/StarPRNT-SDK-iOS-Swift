//
//  PrinterExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class PrinterExtViewController: CommonLabelViewController, StarIoExtManagerDelegate {
    @IBOutlet weak var printButton: UIButton!
    
    var starIoExtManager: StarIoExtManager!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.printButton.isEnabled           = true
        self.printButton.backgroundColor   = UIColor.cyan
        self.printButton.layer.borderColor = UIColor.blue.cgColor
        self.printButton.layer.borderWidth = 1.0
        
        self.appendRefreshButton(#selector(PrinterExtViewController.refreshPrinter))
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(PrinterExtViewController.applicationWillResignActive), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PrinterExtViewController.applicationDidBecomeActive),  name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
        
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
                self.refreshPrinter()
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
    
    @IBAction func touchUpInsidePrintButton(_ sender: UIButton) {
        let commands: Data
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let width: Int = AppDelegate.getSelectedPaperSize().rawValue
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        switch AppDelegate.getSelectedIndex() {
        case 0 :
            commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false)
        case 1 :
            commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true)
        case 2, 7 :
            commands = PrinterFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts)
        case 3 :
            commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true)
        case 4 :
            commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false)
        case 5 :
            commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.normal)
//      case 6  :
        default :
            commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.right90)
        }
        
        self.setBlind(true)
        
        self.starIoExtManager.lock.lock()
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                _ = Communication.sendCommands(commands,
                                               port:self.starIoExtManager.port,
                                               completionHandler: { (communicationResult: CommunicationResult) in
                    DispatchQueue.main.async {
                        self.showSimpleAlert(title: "Communication Result",
                                             message: Communication.getCommunicationResultMessage(communicationResult),
                                             buttonTitle: "OK",
                                             buttonStyle: .cancel)
                        
                        self.starIoExtManager.lock.unlock()
                        
                        self.setBlind(false)
                    }
                })
            }
        }
    }
    
    @objc func refreshPrinter() {
        self.setBlind(true)
        
        defer {
            self.setBlind(false)
        }
        
        self.starIoExtManager.disconnect()
        
        if self.starIoExtManager.connect() == false {
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to openPort",
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel,
                                 completion: { _ in
                self.setCommentLabel(text: """
                                    Check the device. (Power and Bluetooth pairing)
                                    Then touch up the Refresh button.
                                    """,
                                     color: UIColor.red)

            })
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
