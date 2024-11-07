//
//  PrinterExtWithConnectAsyncViewController.swift
//  Swift SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

import UIKit

class PrinterExtWithConnectAsyncViewController: PrinterExtViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GlobalQueueManager.shared.serialQueue.async {
            DispatchQueue.main.async {
                self.refreshPrinter()
            }
        }
    }
    
    override func refreshPrinter() {
        self.setBlind(true)
        
        self.starIoExtManager.disconnect()
        
        self.starIoExtManager.connectAsync()
    }
    
    @IBAction override func touchUpInsidePrintButton(_ sender: UIButton) {
        let commands: Data
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(),
                                                                                          paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        switch emulation {
        case .starDotImpact:
            commands = PrinterFunctions.createTextReceiptData(emulation,
                                                              localizeReceipts: localizeReceipts,
                                                              utf8: false)
        default:
            commands = PrinterFunctions.createRasterReceiptData(emulation,
                                                                localizeReceipts: localizeReceipts)
        }
        
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
    }
    
    func manager(_ manager: StarIoExtManager, didConnectPort portName: String) {
        if self.didAppear == false &&
            self.starIoExtManager.port != nil {
            self.printButton.sendActions(for: UIControl.Event.touchUpInside)
        } else {
            self.setBlind(false)
        }
        
        self.didAppear = true
    }

    func manager(_ manager: StarIoExtManager, didFailToConnectPort portName: String, error: Error?) {
        if let error = error as NSError? {
            self.showSimpleAlert(title: "Communication Result",
                                 message: Communication.getCommunicationResultMessage(CommunicationResult.init(.errorOpenPort, error.code)),
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel,
                                 completion: { _ in
                self.setCommentLabel(text: """
                                    \(error.localizedDescription)
                                    
                                    Check the device. (Power and Bluetooth pairing)
                                    Then touch up the Refresh button.
                                    """,
                                     color: UIColor.red)
                   
                self.setBlind(false)
            })
        }
        
        self.didAppear = true
    }
}
