//
//  CashDrawerExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CashDrawerExtViewController: CommonLabelViewController, StarIoExtManagerDelegate {
    @IBOutlet weak var openButton: UIButton!
    
    var starIoExtManager: StarIoExtManager!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.openButton.isEnabled           = true
        self.openButton.backgroundColor   = UIColor.cyan
        self.openButton.layer.borderColor = UIColor.blue.cgColor
        self.openButton.layer.borderWidth = 1.0
        
        self.appendRefreshButton(#selector(CashDrawerExtViewController.refreshCashDrawer))
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(CashDrawerExtViewController.applicationWillResignActive), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CashDrawerExtViewController.applicationDidBecomeActive),  name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
        
//      self.refreshCashDrawer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.refreshCashDrawer()
                
                if self.didAppear == false {
                    if self.starIoExtManager.port != nil {
                        self.openButton.sendActions(for: UIControl.Event.touchUpInside)
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
                self.refreshCashDrawer()
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
    
    @IBAction func touchUpInsideOpenButton(_ sender: UIButton) {
        let commands: Data
        
        switch AppDelegate.getSelectedIndex() {
        case 0, 1 :
            commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.no1)
//      case 2, 3 :
        default   :
            commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.no2)
        }
        
        switch AppDelegate.getSelectedIndex() {
        case 0, 2 :
            self.setBlind(true)
            
            self.starIoExtManager.lock.lock()
            
            GlobalQueueManager.shared.serialQueue.async {
                DispatchQueue.main.async {
                    _ = Communication.sendCommands(commands,
                                                   port: self.starIoExtManager.port,
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
//      case 1, 3 :
        default   :
            self.setBlind(true)

            self.starIoExtManager.lock.lock()
            
            GlobalQueueManager.shared.serialQueue.async {
                DispatchQueue.main.async {
                    _ = Communication.sendCommandsDoNotCheckCondition(commands,
                                                                      port: self.starIoExtManager.port,
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
    }
    
    @objc func refreshCashDrawer() {
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
