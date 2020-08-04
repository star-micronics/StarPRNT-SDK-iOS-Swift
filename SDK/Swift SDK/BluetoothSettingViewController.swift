//
//  BluetoothSettingViewController.swift
//  Swift SDK
//
//  Created by *** on 2017/04/24.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

import Foundation

class BluetoothSettingViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource,  TextViewTableViewCellDelegate, SwitchTableViewCellDelegate {
    enum CellParamIndex: Int {
        case titleIndex = 0
    }
    
    enum TableCellIndex: Int {
        case deviceName = 0
        case iOSPortName
        case pinCode
    }
    
    var bluetoothManager: SMBluetoothManager!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    var changePinCode: Bool!
    
    var isSMLSeries: Bool!
    
    var cellArray: NSMutableArray!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.appendRefreshButton(#selector(BluetoothSettingViewController.loadSettings))
        
        let portName:  String             = AppDelegate.getPortName()
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        self.bluetoothManager = SMBluetoothManagerFactory.getManager(portName, emulation: emulation)
        
        self.changePinCode = false
        
        self.isSMLSeries = false
        
        self.cellArray = NSMutableArray()
        
        self.didAppear = false
        
        self.applyButton.isEnabled         = false
        self.applyButton.backgroundColor   = UIColor.cyan
        self.applyButton.layer.borderColor = UIColor.blue.cgColor
        self.applyButton.layer.borderWidth = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didAppear == false {
            // Check firmware version before loading bluetooth setting.
            guard let info = getFirmwareInformation() else {
                self.showSimpleAlert(title: "Communication Result",
                                     message: "Fail to openPort",
                                     buttonTitle: "OK",
                                     buttonStyle: .default,
                                     completion: { _ in
                                        self.navigationController!.popViewController(animated: true)
                })
                
                return
            }
            
            let modelName: String       = info.0
            let firmwareVersion: String = info.1
            
            // Bluetooth setting feature is supported from Ver3.0 or later (SM-S210i, SM-S220i, SM-T300i and SM-T400i).
            if (modelName.hasPrefix("SM-S21") ||
                modelName.hasPrefix("SM-S22") ||
                modelName.hasPrefix("SM-T30") ||
                modelName.hasPrefix("SM-T40")) {
                if (NSString(string: firmwareVersion).doubleValue < 3.0) {
                    let message = "This firmware version \(firmwareVersion) of " +
                    "the device does not support bluetooth setting feature."
                    
                    self.showSimpleAlert(title: "Error",
                                         message: message,
                                         buttonTitle: "OK",
                                         buttonStyle: .default,
                                         completion: { _ in
                                            self.navigationController!.popViewController(animated: true)
                    })
                    
                    return
                }
            }
            
            self.isSMLSeries = modelName.hasPrefix("SM-L")
            
            loadSettings()
            
            self.didAppear = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0, 1, 5 :
            let cellIdentifier: String = "TextFieldTableViewCell"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let customCell: TextViewTableViewCell = cell as! TextViewTableViewCell
            
            let cellParam: [AnyObject] = self.cellArray[indexPath.row] as! [AnyObject]
            
            customCell.titleLabel.text = cellParam[CellParamIndex.titleIndex.rawValue] as? String
            
            customCell.delegate = self
            
            switch indexPath.row {
            case 0 :
                if (self.bluetoothManager.deviceNameCapability == SMBluetoothSettingCapabilitySupport) {
                    customCell.textField.text = self.bluetoothManager.deviceName
                    customCell.textField.isEnabled = true
                }
                else {
                    customCell.textField.text = "N/A"
                    customCell.textField.isEnabled = false
                }
                
                customCell.tag = TableCellIndex.deviceName.rawValue
            case 1 :
                if (self.bluetoothManager.iOSPortNameCapability == SMBluetoothSettingCapabilitySupport) {
                    customCell.textField.text = self.bluetoothManager.iOSPortName
                    customCell.textField.isEnabled = true
                }
                else {
                    customCell.textField.text = "N/A"
                    customCell.textField.isEnabled = false
                }
                
                customCell.tag = TableCellIndex.iOSPortName.rawValue
//          case 5 :
            default :
                if (self.bluetoothManager.pinCodeCapability == SMBluetoothSettingCapabilitySupport) {
                    if customCell.textField.isEnabled && !self.changePinCode {
                        customCell.textField.text = ""
                        
                        self.bluetoothManager.pinCode = nil
                    }
                    else {
                        customCell.textField.text = self.bluetoothManager.pinCode
                    }
                    
                    customCell.textField.isEnabled = self.changePinCode
                }
                else {
                    customCell.textField.text = "N/A"
                    customCell.textField.isEnabled = false
                }
                
                customCell.textField.placeholder = "Input New PIN Code"
                
                customCell.tag = TableCellIndex.pinCode.rawValue
            }
        case 2, 4 :
            let cellIdentifier: String = "SwitchTableViewCell"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let customCell: SwitchTableViewCell = cell as! SwitchTableViewCell

            let cellParam: [AnyObject] = self.cellArray[indexPath.row] as! [AnyObject]
            
            customCell.titleLabel.text = cellParam[CellParamIndex.titleIndex.rawValue] as? String
            
            customCell.delegate = self
            
            switch indexPath.row {
            case 2 :
                if (self.bluetoothManager.autoConnectCapability == SMBluetoothSettingCapabilitySupport) {
                    customCell.stateSwitch.isEnabled = true
                    customCell.stateSwitch.isOn = self.bluetoothManager.autoConnect

                    customCell.detailLabel!.text = ""
                }
                else {
                    customCell.stateSwitch.isEnabled = false
                    customCell.stateSwitch.isOn = false
                    
                    customCell.detailLabel!.text = "N/A"
                }
//          case 4 :
            default :
                if (self.bluetoothManager.pinCodeCapability == SMBluetoothSettingCapabilitySupport) {
                    customCell.stateSwitch.isOn = changePinCode
                    
                    customCell.stateSwitch.isEnabled = true
                    
                    customCell.detailLabel!.text = ""
                }
                else {
                    customCell.stateSwitch.isOn = false
                    
                    customCell.stateSwitch.isEnabled = false
                    
                    customCell.detailLabel!.text = "N/A"
                }
            }
//      case 3 :
        default :
            let cellIdentifier: String = "UITableViewCellStyleValue1"
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let cellParam: [AnyObject] = self.cellArray[indexPath.row] as! [AnyObject]
            
            cell.textLabel!.text = cellParam[CellParamIndex.titleIndex.rawValue] as? String
            
            if (self.bluetoothManager.pinCodeCapability == SMBluetoothSettingCapabilitySupport) {
                if (self.bluetoothManager.security == SMBluetoothSecuritySSP) {
                    cell.detailTextLabel!.text = "SSP"
                }
                else if (self.bluetoothManager.security == SMBluetoothSecurityPINcode) {
                    cell.detailTextLabel!.text = "PIN Code"
                }
                else {  // Disable
                    cell.detailTextLabel!.text = "Disable"
                }
                
                cell.detailTextLabel!.textColor = UIColor.blue
            }
            else {
                cell.detailTextLabel!.text = "N/A"
                
                cell.detailTextLabel!.textColor = UIColor.darkText
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sample"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 3) {
            if (self.bluetoothManager.pinCodeCapability == SMBluetoothSettingCapabilitySupport) {
                self.showSecuritySelectionAlert(deviceType: self.bluetoothManager.deviceType)
            }
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showSecuritySelectionAlert(deviceType: SMDeviceType) {
        let alert = UIAlertController(title: "Select security type.",
                                      message: nil,
                                      preferredStyle: .alert)
        
        func addSecuritySelection(title: String, securitySetting: SMBluetoothSecurity) {
            let selectedSSPAction = UIAlertAction(title: title,
                                                  style: .default,
                                                  handler: { _ in
                                                    self.bluetoothManager.security = securitySetting
                                                    self.applyButton.isEnabled = self.validateStringSettings()
                                                    self.refreshTableView()
            })
            alert.addAction(selectedSSPAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        switch deviceType {
        case SMDeviceTypeDesktopPrinter, SMDeviceTypeDKAirCash:
            addSecuritySelection(title: "SSP", securitySetting: SMBluetoothSecuritySSP)
            addSecuritySelection(title: "PIN Code", securitySetting: SMBluetoothSecurityPINcode)
            alert.addAction(cancelAction)
        case SMDeviceTypePortablePrinter:
            addSecuritySelection(title: "PIN Code", securitySetting: SMBluetoothSecurityPINcode)
            addSecuritySelection(title: "Disable", securitySetting: SMBluetoothSecurityDisable)
            alert.addAction(cancelAction)
        default:
            preconditionFailure()
            break
        }

        self.present(alert, animated: true)
    }
    
    // Called when text field value changed.
    func shouldChangeCharactersIn(tableViewCellTag tag: Int, textValue: String, range: NSRange, replacementString string: String) -> Bool {
        let newTextValue = (textValue as NSString?)?.replacingCharacters(in: range, with: string)
        
        defer {
            self.applyButton.isEnabled = validateStringSettings()
        }
        
        switch tag {
        case TableCellIndex.deviceName.rawValue :
            if (validateNameChars(name: newTextValue) &&
                newTextValue!.count <= 16) {
                self.bluetoothManager.deviceName = newTextValue
                
                return true
            }
            else {
                return false
            }
        case TableCellIndex.iOSPortName.rawValue :
            if (validateNameChars(name: newTextValue) &&
                newTextValue!.count <= 16) {
                self.bluetoothManager.iOSPortName = newTextValue
                
                return true
            }
            else {
                return false
            }
        default :
//      case TableCellIndex.pinCode.rawValue :
            if (self.bluetoothManager.pinCodeCapability == SMBluetoothSettingCapabilityNoSupport) {
                return true
            }
            
            if (isSMLSeries) {
                if (validateSMLSeriesPinCodeChars(pinCode: newTextValue) &&
                    newTextValue!.count <= 4) {
                    self.bluetoothManager.pinCode = newTextValue
                    
                    return true
                }
                else {
                    return false
                }
            }
            else {
                if (validatePinCodeChars(pinCode: newTextValue) &&
                    newTextValue!.count <= 16) {
                    self.bluetoothManager.pinCode = newTextValue
                    
                    return true
                }
                else {
                    return false
                }
            }
        }
    }

    // Called when switch value changed.
    func tableView(_ tableView: UITableView, valueChangedStateSwitch on: Bool, indexPath: IndexPath) {
        switch indexPath.row {
        case 2 :
            self.bluetoothManager.autoConnect = on
//      case 4 :
        default:
            self.changePinCode = on
        }
        
        self.applyButton.isEnabled = validateStringSettings()

        self.tableView.reloadData()
    }
    
    @IBAction func touchUpInsideApplyButton(sender: UIButton) {
        confirmSettings()
    }
    
    func refreshTableView() {
        self.cellArray.removeAllObjects()
        
        self.cellArray.add(["Device Name"])
        self.cellArray.add(["iOS Port Name"])
        self.cellArray.add(["Auto Connect"])
        self.cellArray.add(["Security"])
        self.cellArray.add(["Change PIN Code"])
        self.cellArray.add(["New PIN Code"])
        
        self.tableView.reloadData()
    }
    
    func getFirmwareInformation() -> (String, String)? {
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
            
            defer {
                SMPort.release(port)
            }
            
            // Sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
            // (Refer Readme for details)
            if #available(iOS 11.0, *), portName.uppercased().hasPrefix("BT:") {
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            let dictionary = try port.getFirmwareInformation()
            
            let modelName:       String = dictionary["ModelName"]       as! String
            let firmwareVersion: String = dictionary["FirmwareVersion"] as! String
            
            return (modelName, firmwareVersion)
        }
        catch {
            // do nothing
        }
        
        return nil
    }
    
    @objc func loadSettings() {
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        if (self.bluetoothManager.open() == false) {
            self.cellArray.removeAllObjects()
            
            self.tableView.reloadData()
            
            self.applyButton.isEnabled = false
            
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to openPort",
                                 buttonTitle: "OK",
                                 buttonStyle: .default)
            
            return
        }
        
        if (self.bluetoothManager.loadSetting() == false) {
            self.cellArray.removeAllObjects()
            
            self.tableView.reloadData()
            
            self.applyButton.isEnabled = false
            
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to load settings.",
                                 buttonTitle: "OK",
                                 buttonStyle: .default)
            
            self.bluetoothManager.close()
            
            return
        }
        
        self.bluetoothManager.close()

        self.changePinCode = false
        
        self.applyButton.isEnabled = validateStringSettings()
        
        refreshTableView()
    }
    
    func confirmSettings() {
        if ((self.bluetoothManager.deviceType == SMDeviceTypeDesktopPrinter) ||
            (self.bluetoothManager.deviceType == SMDeviceTypeDKAirCash)) {
            if (self.bluetoothManager.autoConnect == true &&
                self.bluetoothManager.security    == SMBluetoothSecurityPINcode) {

                let message = "Auto Connection function is available only when the security setting is \"SSP\"."

                self.showSimpleAlert(title: "Error",
                                     message: message,
                                     buttonTitle: "OK",
                                     buttonStyle: .default)
                
                return
            }
        }
        
        if (self.changePinCode) {
            if (!validateSMLSeriesPinCodeChars(pinCode: bluetoothManager.pinCode)) {    // Unless PIN Code contains only numeric characters.

                
                let alert = UIAlertController(title: "Warning",
                                              message: "iPhone and iPod touch cannot use Alphabet PIN code, iPad only can use.",
                                              preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    DispatchQueue.main.async {
                        self.applySettings()
                    }
                }
                alert.addAction(okAction)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
                
                return
            }
        }
        else {
            self.bluetoothManager.pinCode = nil;
        }
        
        applySettings()
    }
    
    func applySettings() {
        guard validateStringSettings() else {
            return
        }
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        if (self.bluetoothManager.open() == false) {
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to openPort",
                                 buttonTitle: "OK",
                                 buttonStyle: .default)
            
            return
        }
       
        if (self.bluetoothManager.apply() == false) {
            self.showSimpleAlert(title: "Communication Result",
                                 message: "Fail to apply settings.",
                                 buttonTitle: "OK",
                                 buttonStyle: .default)
            
            self.bluetoothManager.close()
            
            return
        }
        
        self.bluetoothManager.close()
        
        self.showSimpleAlert(title: "Complete",
                             message: "To apply settings, please turn the device power OFF and ON, and establish pairing again.",
                             buttonTitle: "OK",
                             buttonStyle: .default,
                             completion: { _ in
                                self.navigationController!.popViewController(animated: true)
        })
    }
    
    func validateStringSettings() -> Bool {
        var isValidDeviceName: Bool = true
        
        // Device name and iOS port name can use alphabetical(A-Z,a-z), numeric(0-9) and some symbol characters(see SDK manual),
        // and its length must be from 1 to 16.
        if (self.bluetoothManager.deviceNameCapability == SMBluetoothSettingCapabilitySupport) {
            isValidDeviceName = validateNameChars (name: self.bluetoothManager.deviceName) &&
                                validateNameLength(name: self.bluetoothManager.deviceName)
        }
        
        var isValidiOSPortName: Bool = true
        
        if (self.bluetoothManager.iOSPortNameCapability == SMBluetoothSettingCapabilitySupport) {
            isValidiOSPortName = validateNameChars (name: self.bluetoothManager.iOSPortName) &&
                                 validateNameLength(name: self.bluetoothManager.iOSPortName)
        }

        var isValidPinCode: Bool = true
        
        // PIN code for SM-L series must be four numeric(0-9) characteres.
        // Other models can use alphabetical(A-Z,a-z) and numeric(0-9) PIN code, and its length must be from 4 to 16.
        if (self.bluetoothManager.pinCodeCapability == SMBluetoothSettingCapabilitySupport &&
            self.changePinCode) {

            if (isSMLSeries) {
                isValidPinCode = validateSMLSeriesPinCodeChars(pinCode: self.bluetoothManager.pinCode) &&
                                 validateSMLSeriesPinCodeLength(pinCode: self.bluetoothManager.pinCode)
            }
            else {
                isValidPinCode = validatePinCodeChars(pinCode: self.bluetoothManager.pinCode) &&
                                 validatePinCodeLength(pinCode: self.bluetoothManager.pinCode)
            }
        }

        return isValidDeviceName && isValidiOSPortName && isValidPinCode
    }

    func validateNameChars(name: String?) -> Bool {
        guard let name = name else {
            return false
        }
        
        let range: Range? = name.range(of: "^[A-Za-z0-9;:!?#$%&,.@_\\-= \\\\/\\*\\+~\\^\\[\\{\\(\\]\\}\\)\\|]*$", options: NSString.CompareOptions.regularExpression)
        
        return range != nil
    }
    
    func validatePinCodeChars(pinCode: String?) -> Bool {
        guard let pinCode = pinCode else {
            return false
        }
        
        let range: Range? = pinCode.range(of: "^[A-Za-z0-9]*$", options: NSString.CompareOptions.regularExpression)
        
        return range != nil
    }
    
    func validateSMLSeriesPinCodeChars(pinCode: String?) -> Bool {
        guard let pinCode = pinCode else {
            return false
        }
        
        let range: Range? = pinCode.range(of: "^[0-9]*$", options: NSString.CompareOptions.regularExpression)
        
        return range != nil
    }
    
    func validateNameLength(name: String?) -> Bool {
        guard let name = name else {
            return false
        }
        
        return 1...16 ~= name.count
    }
    
    func validatePinCodeLength(pinCode: String?) -> Bool {
        guard let pinCode = pinCode else {
            return false
        }
        
        return 4...16 ~= pinCode.count
    }
    
    func validateSMLSeriesPinCodeLength(pinCode: String?) -> Bool {
        guard let pinCode = pinCode else {
            return false
        }
        
        return pinCode.count == 4
    }
}
