//
//  BlackMarkPasteViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

import UIKit

class BlackMarkPasteViewController: CommonViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var doubleHeightSwitch: UISwitch!
    @IBOutlet weak var detectionSwitch:    UISwitch!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var printButton: UIButton!
    
    @IBOutlet weak var detectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let toolBar: UIToolbar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        
        toolBar.sizeToFit()
        
        let spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(BlackMarkPasteViewController.closeKeyboard(textView:)))
        
        toolBar.items = [spacer, doneButton]
        
        self.textView.inputAccessoryView = toolBar
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        self.textView.text = localizeReceipts.createPasteTextLabelString()
        
        self.textView.layer.borderWidth = 1.0
        
        let modelIndex = AppDelegate.getSelectedModelIndex()
        
        let printerInfo = ModelCapability.modelCapabilityDictionary[modelIndex!]!
        
        if printerInfo.blackMarkDetectionIsEnabled {
            self.detectionSwitch.isEnabled = true
//          self.detectionLabel .isEnabled = true
            self.detectionLabel .alpha     = 1.0
        }
        else {
            self.detectionSwitch.isEnabled = false
//          self.detectionLabel .isEnabled = false
            self.detectionLabel .alpha     = 0.3
        }
        
        self.clearButton.isEnabled         = true
//      self.clearButton.backgroundColor   = UIColor.cyan
        self.clearButton.backgroundColor   = UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0)
        self.clearButton.layer.borderColor = UIColor.blue.cgColor
        self.clearButton.layer.borderWidth = 1.0
        
        self.printButton.isEnabled         = true
        self.printButton.backgroundColor   = UIColor.cyan
        self.printButton.layer.borderColor = UIColor.blue.cgColor
        self.printButton.layer.borderWidth = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func closeKeyboard(textView : UITextView){
        self.textView.endEditing(true)
    }
    
    func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func touchUpInsideClearButton(sender: UIButton) {
        self.textView.text = ""
    }
    
    @IBAction func touchUpInsidePrintButton(sender: UIButton) {
        let commands: Data
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        let type: SCBBlackMarkType
        
        if self.detectionSwitch.isOn == false {
            type = SCBBlackMarkType.valid
        }
        else {
            type = SCBBlackMarkType.validWithDetection
        }
        
        commands = PrinterFunctions.createPasteTextBlackMarkData(emulation, localizeReceipts: localizeReceipts, pasteText: textView.text, doubleHeight: doubleHeightSwitch.isOn, type: type, utf8: false)
        
        self.blind = true
        
        let portName:     String = AppDelegate.getPortName()
        let portSettings: String = AppDelegate.getPortSettings()
        let timeout:      UInt32 = 10000                             // 10000mS!!!
        
        GlobalQueueManager.shared.serialQueue.async {
            _ = Communication.sendCommands(commands,
                                           portName: portName,
                                           portSettings: portSettings,
                                           timeout: timeout,
                                           completionHandler: { (communicationResult: CommunicationResult) in
                                            DispatchQueue.main.async {
                                                self.showSimpleAlert(title: "Communication Result",
                                                                     message: Communication.getCommunicationResultMessage(communicationResult),
                                                                     buttonTitle: "OK",
                                                                     buttonStyle: .cancel)
                                                
                                                self.blind = false
                                            }
            })
        }
    }
}
