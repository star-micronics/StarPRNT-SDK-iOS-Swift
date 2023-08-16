//
//  ViewController.swift
//  StarIODeviceSettingSDK
//
//  Copyright © 2020 u3237. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var portNameTextField: UITextField!
    
    @IBOutlet weak var steadyLANSettingButton: UIButton!
    
    var steadyLANSetting: SMSteadyLANSetting = .unspecified
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portNameTextField.delegate = self
    }
    
    @IBAction func load(_ sender: Any) {
        guard let portName = self.portNameTextField.text else { return }

        DispatchQueue.global().async {
            debugPrint("Load SteadyLAN Setting")
            
            // Please refer to the SDK manual for portName argument which using for communicating with the printer.
            // (https://www.star-m.jp/products/s_print/sdk/starprnt_sdk/manual/ios_swift/en/api_stario_port.html#getport)
            guard let starNetworkManager = SMNetworkManager(portName:portName) else { return }
            
            let starNetworkSetting : SMNetworkSetting
            
            do {
                starNetworkSetting = try starNetworkManager.load()
                
                let networkSettingString: String
                switch starNetworkSetting.steadyLAN {
                case .unspecified:
                    networkSettingString = "unspecified"
                case .disable:
                    networkSettingString = "disable"
                case .iOS:
                    networkSettingString = "iOS"
                case .android:
                    networkSettingString = "android"
                case .windows:
                    networkSettingString = "windows"
                @unknown default:
                    networkSettingString = ""
                }
                
                DispatchQueue.main.async {
                    self.showAlert(title: "Communication Result",
                                   message: "SteadyLAN Setting : " + networkSettingString)
                }
            } catch {
                DispatchQueue.main.async {
                    self.showAlert(title: "Communication Result",
                                   message: error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func apply(_ sender: Any) {
        guard let portName = self.portNameTextField.text else { return }
        
        DispatchQueue.global().async {
            debugPrint("Apply SteadyLAN Setting")
            
            // Please refer to the SDK manual for portName argument which using for communicating with the printer.
            // (https://www.star-m.jp/products/s_print/sdk/starprnt_sdk/manual/ios_swift/en/api_stario_port.html#getport)
            guard let starNetworkManager = SMNetworkManager(portName: portName) else { return }
            let starNetworkSetting = SMNetworkSetting()
            
            switch self.steadyLANSetting {
            case .unspecified:
                starNetworkSetting.steadyLAN = .unspecified
            case .disable:
                starNetworkSetting.steadyLAN = .disable
            case .iOS:
                starNetworkSetting.steadyLAN = .iOS
            case .android:
                starNetworkSetting.steadyLAN = .android
            case .windows:
                starNetworkSetting.steadyLAN = .windows
            @unknown default:
                return
            }
            
            do {
                try starNetworkManager.apply(starNetworkSetting)
                
                DispatchQueue.main.async {
                    self.showAlert(title: "Communication Result",
                                   message: """
                                            Data transmission succeeded.
                                            Please confirm the current settings by load method after a printer reset is executed.
                                            """)
                }
            } catch {
                DispatchQueue.main.async {
                    self.showAlert(title: "Communication Result", message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - UIAlertController
    
    @IBAction func showSteadyLANSettingOptions(_ sender: Any) {
        let alert = UIAlertController(title: "SteadyLANSetting",
                                      message: nil,
                                      preferredStyle: .alert)

        let selectedUnspecified = UIAlertAction(title: "Unspecified", style: .default) { action in
            self.steadyLANSettingButton.setTitle(action.title, for: .normal)
            self.steadyLANSetting = .unspecified
        }
        alert.addAction(selectedUnspecified)
            
        let selectedDisable = UIAlertAction(title: "Disable", style: .default) { action in
            self.steadyLANSettingButton.setTitle(action.title, for: .normal)
            self.steadyLANSetting = .disable
        }
        alert.addAction(selectedDisable)

        let selectedEnableIOS = UIAlertAction(title: "Enable (for iOS)", style: .default) { action in
            self.steadyLANSettingButton.setTitle(action.title, for: .normal)
            self.steadyLANSetting = .iOS
        }
        alert.addAction(selectedEnableIOS)
        
        let selectedEnableAndroid = UIAlertAction(title: "Enable (for Android)", style: .default) { action in
            self.steadyLANSettingButton.setTitle(action.title, for: .normal)
            self.steadyLANSetting = .android
        }
        alert.addAction(selectedEnableAndroid)
        
        let selectedWindows = UIAlertAction(title: "Enable (for Windows)", style: .default) { action in
            self.steadyLANSettingButton.setTitle(action.title, for: .normal)
            self.steadyLANSetting = .windows
        }
        alert.addAction(selectedWindows)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Alert
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

