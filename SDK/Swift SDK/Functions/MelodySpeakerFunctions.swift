//
//  MelodySpeakerFunctions.swift
//  Swift SDK
//
//  Copyright (c) 2018 Star Micronics. All rights reserved.
//

import UIKit

class MelodySpeakerFunctions: NSObject {
    static func createPlayingRegisteredSound(with model: StarIoExtMelodySpeakerModel,
                                             specifySound: Bool,
                                             soundStorageArea: SMCBSoundStorageArea?,
                                             soundNumber: Int,
                                             specifyVolume: Bool,
                                             volume: Int,
                                             error: inout NSError?) -> Data? {
        let builder = StarIoExt.createMelodySpeakerCommandBuilder(model)!
        
        let setting = SMSoundSetting()
        
        if specifySound {
            setting.soundStorageArea = soundStorageArea!
            setting.soundNumber = soundNumber
        }
        
        if specifyVolume {
            setting.volume = volume
        }

        builder.appendSound(with: setting, error: &error)
        
        if error != nil {
            return nil
        }
        
        print(builder.commands)
        
        return builder.commands as Data
    }
    
    static func createPlayingReceivedData(with model: StarIoExtMelodySpeakerModel,
                                       filePath: String,
                                       specifyVolume: Bool,
                                       volume: Int,
                                       error: inout NSError?) -> Data? {
        let builder = StarIoExt.createMelodySpeakerCommandBuilder(model)!
        
        guard let filePathURL = URL(string: filePath) else {
            print("File open error")
            return nil
        }
        
        let fileData = try! Data(contentsOf: filePathURL, options: [])
        
        let soundSetting = SMSoundSetting()
        
        if specifyVolume {
            soundSetting.volume = volume
        }

        builder.appendSound(withSound: fileData, setting: soundSetting, error: &error)
        
        if error != nil {
            return nil
        }

        return builder.commands as Data
    }
}
