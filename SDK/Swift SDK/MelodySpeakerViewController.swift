//
//  MelodySpeakerViewController.swift
//  Swift SDK
//
//  Created by u3237 on 2018/08/23.
//  Copyright © 2018年 Star Micronics. All rights reserved.
//

import UIKit

class MelodySpeakerViewController: CommonViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var soundTypeSegment: UISegmentedControl!
    @IBOutlet weak var soundStorageAreaButton: UIButton!
    @IBOutlet weak var soundNumberLabel: UILabel!
    @IBOutlet weak var soundNumberField: UITextField!
    @IBOutlet weak var soundFileButton: UIButton!
    @IBOutlet weak var volumeSettingButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var soundStorageAreaView: UIView!
    @IBOutlet weak var soundFileView: UIView!
    @IBOutlet weak var volumeView: UIView!
    @IBOutlet weak var playView: UIView!
    
    var selectedSoundStorageArea: SMCBSoundStorageArea? = nil
    var selectedSoundNumber: Int? {
        get {
            guard let rawText = soundNumberField.text else {
                return nil
            }
            
            return Int(rawText)
        }
    }
    var selectedSoundFilePath: String? = nil
    
    enum VolumeSetting {
        case `default`
        case off
        case min
        case max
        case manual
        
        func title() -> String {
            switch self {
            case .default:
                return "Default"
            case .off:
                return "Off"
            case .min:
                return "Min"
            case .max:
                return "Max"
            case .manual:
                return "Manual"
            }
        }
        
        func value() -> Int {
            switch self {
            case .off:
                return SMSoundSettingVolume.off.rawValue
            case .min:
                return SMSoundSettingVolume.min.rawValue
            case .max:
                return SMSoundSettingVolume.max.rawValue
            default:
                return 0
            }
        }
        
        func specifyVolume() -> Bool {
            if self == .default {
                return false
            } else {
                return true
            }
        }
    }
    var selectedVolumeSetting: VolumeSetting = .default
    
    var selectedVolume: UInt = 12
    
    var melodySpeakerModel: StarIoExtMelodySpeakerModel
    
    required init?(coder aDecoder: NSCoder) {
        guard let modelIndex = AppDelegate.getSelectedModelIndex() else {
            fatalError()
        }
        
        guard let printerInfo = ModelCapability.modelCapabilityDictionary[modelIndex] else {
            fatalError()
        }
        
        if printerInfo.title == "mC-Print3" {
            melodySpeakerModel = .MCS10
        } else {
            melodySpeakerModel = .FVP10
        }
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundFileButton.setTitle(selectedSoundFilePath ?? "(Unselected)",
                                 for: .normal)
        volumeLabel.text = "\(selectedVolume)"
        
        playButton.backgroundColor   = UIColor.cyan
        playButton.layer.borderColor = UIColor.blue.cgColor
        playButton.layer.borderWidth = 1.0;
        
        scrollView.contentSize.height = 338
        
        soundStorageAreaButton.setTitle("Default", for: .normal)
        
        switch melodySpeakerModel {
        case .MCS10:
            soundNumberField.text = "0"
        case .FVP10:
            soundNumberField.text = "1"
            
            volumeSettingButton.isEnabled = false
        case .none:
            volumeSettingButton.isEnabled = false
        @unknown default:
            fatalError()
        }
        
        let toolbar: UIToolbar = UIToolbar()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        
        let done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(closeKeyboard))
        
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        soundNumberField.inputAccessoryView = toolbar
        
        reloadView()
    }

    @objc func closeKeyboard() {
        soundNumberField.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changedSoundType(_ sender: Any) {
        reloadView()
    }
    
    @IBAction func changedVolume(_ sender: Any) {
        let newValue = UInt(volumeSlider.value)
        
        selectedVolume = newValue

        volumeLabel.text = String(newValue)
    }
    
    func reloadView() {
        switch soundTypeSegment.selectedSegmentIndex {
        case 0:
            soundStorageAreaView.isHidden = false
            soundFileView.isHidden        = true
        case 1:
            soundStorageAreaView.isHidden = true
            soundFileView.isHidden        = false
        default:
            fatalError()
        }
    }
    
    @IBAction func showAreaSelectAlert(_ sender: Any) {
        let button = sender as! UIButton

        let alert = UIAlertController(title: "Select sound storage area.", message: nil, preferredStyle: .alert)

        let selectedDefaultAction = UIAlertAction(title: "Default", style: .default) { action in
            button.setTitle(action.title, for: .normal)
            
            self.selectedSoundStorageArea = nil
            
            self.soundNumberField.isEnabled = false
        }
        alert.addAction(selectedDefaultAction)

        let selectedArea1Action = UIAlertAction(title: "Area1", style: .default) { action in
            button.setTitle(action.title, for: .normal)
            
            self.selectedSoundStorageArea = .area1
            
            self.soundNumberField.isEnabled = true
        }
        alert.addAction(selectedArea1Action)
        
        let selectedArea2Action = UIAlertAction(title: "Area2", style: .default) {
            action in
            button.setTitle(action.title, for: .normal)
            
            self.selectedSoundStorageArea = .area2
            
            self.soundNumberField.isEnabled = true
        }
        alert.addAction(selectedArea2Action)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showVolumeSettingAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Select volume.", message: nil, preferredStyle: .alert)
        
        let volumeSettings: [VolumeSetting] = [.default, .off, .min, .max, .manual]
        
        volumeSettings.forEach { setting in
            let action = UIAlertAction(title: setting.title(), style: .default) { action in
                self.selectedVolumeSetting = setting
                
                self.volumeSettingButton.setTitle(setting.title(), for: .normal)

                self.volumeSlider.isHidden = setting != .manual
                self.volumeLabel.isHidden  = setting != .manual
            }
            alert.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SoundFileViewController
        
        destination.didSelectSoundFileHandler = { filePath in
            self.selectedSoundFilePath = filePath

            let fileName = NSString(string: filePath).lastPathComponent.removingPercentEncoding
            self.soundFileButton.setTitle(fileName, for: .normal)
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        soundNumberField.resignFirstResponder()
        
        sendCommandsToPrinter(segmentIndex: soundTypeSegment.selectedSegmentIndex)
    }
    
    func sendCommandsToPrinter(segmentIndex: Int) {
        if segmentIndex == 1 && selectedSoundFilePath == nil {  // Received Data
            showSimpleAlert(title: "Sound file is not selected.",
                            message: nil,
                            buttonTitle: "OK",
                            buttonStyle: .default)
            return
        }
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        var port : SMPort
        
        let portName = AppDelegate.getPortName()
        
        do {
            // Modify portSettings argument to improve connectivity when continously connecting via some Ethernet/Wireless LAN model.
            // (Refer Readme for details)
//          port = try SMPort.getPort(portName: portName, portSettings: "(your original portSettings);l1000)", ioTimeoutMillis: 10000)
            port = try SMPort.getPort(portName: portName, portSettings: AppDelegate.getPortSettings(), ioTimeoutMillis: 10000)
        }
        catch let error as NSError {
            self.showSimpleAlert(title: "Communication Result",
                                 message: Communication.getCommunicationResultMessage(CommunicationResult.init(.errorOpenPort, error.code)),
                                 buttonTitle: "OK",
                                 buttonStyle: .cancel)
            return
        }
        
        defer {
            SMPort.release(port)
        }
        
        // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
        // (Refer Readme for details)
        if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
            Thread.sleep(forTimeInterval: 0.2)
        }
        
        if melodySpeakerModel == .MCS10 {
            do {
                let parser = try StarIoExt.createMelodySpeakerConnectParser(.MCS10)
                
                _ = Communication.parseDoNotCheckCondition(parser,
                                                           port: port,
                                                           completionHandler: { (communicationResult: CommunicationResult) in
                                                            if communicationResult.result == .success {
                                                                if parser.connect() == true {
                                                                    let commands : Data?
                                                                    
                                                                    if (segmentIndex == 0) {    // Registered Sound
                                                                        commands = self.createRegisteredSoundCommand()
                                                                    } else {                    // Received Data
                                                                        commands = self.createReceivedDataCommand()
                                                                    }
                                                                    
                                                                    if (commands == nil) {
                                                                        return
                                                                    }
                                                                    
                                                                    _ = Communication.sendCommands(commands,
                                                                                                   port: port,
                                                                                                   completionHandler: { (communicationResult: CommunicationResult) in
                                                                                                    self.showSimpleAlert(title: "Communication Result",
                                                                                                                         message: Communication.getCommunicationResultMessage(communicationResult),
                                                                                                                         buttonTitle: "OK",
                                                                                                                         buttonStyle: .cancel)
                                                                    })
                                                                }
                                                                else {
                                                                    self.showSimpleAlert(title: "Check Status",
                                                                                         message: "MelodySpeaker Disconnect.",
                                                                                         buttonTitle: "OK",
                                                                                         buttonStyle: .cancel)
                                                                }
                                                            }
                                                            else {
                                                                self.showSimpleAlert(title: "Communication Result",
                                                                                     message: Communication.getCommunicationResultMessage(communicationResult),
                                                                                     buttonTitle: "OK",
                                                                                     buttonStyle: .cancel)
                                                            }
                })
            } catch {
                fatalError()
            }
        } else {
            let commands : Data?
            
            if (segmentIndex == 0) {    // Registered Sound
                commands = self.createRegisteredSoundCommand()
            } else {                    // Received Data
                commands = self.createReceivedDataCommand()
            }
            
            if (commands == nil) {
                return
            }
            
            _ = Communication.sendCommands(commands,
                                           port: port,
                                           completionHandler: { (communicationResult: CommunicationResult) in
                                            self.showSimpleAlert(title: "Communication Result",
                                                                 message: Communication.getCommunicationResultMessage(communicationResult),
                                                                 buttonTitle: "OK",
                                                                 buttonStyle: .cancel)
            })
        }
    }
    
    func createRegisteredSoundCommand() -> Data? {
        let specifySound: Bool
        let soundStorageArea: SMCBSoundStorageArea? = selectedSoundStorageArea
        
        specifySound = soundStorageArea != nil
        
        let soundNumber: Int

        if selectedSoundNumber != nil {
            soundNumber = selectedSoundNumber!
        } else {
            let number = soundNumberField.text ?? ""
            
            showSimpleAlert(title: "Sound Number \"\(number)\" is an invalid value.",
                message: nil,
                buttonTitle: "OK",
                buttonStyle: .default)
            return nil
        }
        
        var specifyVolume: Bool
        var volume: Int = 0
        
        switch selectedVolumeSetting {
        case .default:
            // Not specify volume.
            specifyVolume = false
        case .min:
            volume = SMSoundSettingVolume.min.rawValue
            specifyVolume = true
        case .max:
            volume = SMSoundSettingVolume.max.rawValue
            specifyVolume = true
        case .off:
            volume = SMSoundSettingVolume.off.rawValue
            specifyVolume = true
        case .manual:
            volume = Int(selectedVolume)
            specifyVolume = true
        }

        var error: NSError? = nil
        guard let data = MelodySpeakerFunctions.createPlayingRegisteredSound(with: melodySpeakerModel,
                                                                             specifySound: specifySound,
                                                                             soundStorageArea: soundStorageArea,
                                                                             soundNumber: soundNumber,
                                                                             specifyVolume: specifyVolume,
                                                                             volume: volume,
                                                                             error: &error) else {
                                                                                showSimpleAlert(title: error?.localizedDescription,
                                                                                                message: nil,
                                                                                                buttonTitle: "OK",
                                                                                                buttonStyle: .default)
                                                                                return nil
        }

        return data
    }
    
    func createReceivedDataCommand() -> Data? {
        let filePath: String = selectedSoundFilePath!
        
        var specifyVolume: Bool = false
        var volume: Int = 0
        
        switch selectedVolumeSetting {
        case .default:
            // Not specify volume.
            specifyVolume = false
        case .min:
            volume = SMSoundSettingVolume.min.rawValue
            specifyVolume = true
        case .max:
            volume = SMSoundSettingVolume.max.rawValue
            specifyVolume = true
        case .off:
            volume = SMSoundSettingVolume.off.rawValue
            specifyVolume = true
        case .manual:
            volume = Int(selectedVolume)
            specifyVolume = true
        }
        
        var error: NSError? = nil
        guard let data: Data = MelodySpeakerFunctions.createPlayingReceivedData(with: melodySpeakerModel,
                                                                                filePath: filePath,
                                                                                specifyVolume: specifyVolume,
                                                                                volume: volume,
                                                                                error: &error) else {
                                                                                    showSimpleAlert(title: error?.localizedDescription,
                                                                                                    message: nil,
                                                                                                    buttonTitle: "OK",
                                                                                                    buttonStyle: .default)
                                                                                return nil
        }
        
        return data
    }
}
