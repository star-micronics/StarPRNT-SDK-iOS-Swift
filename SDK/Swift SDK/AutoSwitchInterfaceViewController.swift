//
//  AutoInterfaceSelectViewController.swift
//  Swift SDK
//
//  Created by 上田　雄磨 on 2020/01/10.
//  Copyright © 2020 Star Micronics. All rights reserved.
//

import UIKit

class AutoSwitchInterfaceViewController: CommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func print() {
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(LanguageIndex.english, paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        let commands = PrinterFunctions.createRasterReceiptData(AppDelegate.getEmulation(), localizeReceipts: localizeReceipts)
        
        self.setBlind(true)
        
        let portSettings: String = AppDelegate.getPortSettings()
        
        GlobalQueueManager.shared.serialQueue.async {
            _ = Communication.sendCommandsWithAutoInterfaceSelect(commands,
                                                                  portSettings: portSettings,
                                                                  timeout: 10000,
                completionHandler: { (communicationResult: CommunicationResult, portName: String) in
                    DispatchQueue.main.async {
                        self.showSimpleAlert(title: "Communication Result",
                                             message: Communication.getCommunicationResultMessage(communicationResult) + "\nPort Name: " + portName,
                                             buttonTitle: "OK",
                                             buttonStyle: .cancel)
                        
                        self.setBlind(false)
                    }
            })
        }
    }

    @IBAction func printButtonTouchUpInside(_ sender: Any) {
        print()
    }
}
