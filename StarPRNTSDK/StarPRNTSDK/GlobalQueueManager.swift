//
//  GlobalQueueManager.swift
//  StarPRNTSDK
//
//  Created by StarMicronics on 2017/05/31.
//  Copyright © 2017 Star Micronics. All rights reserved.
//

import Foundation

class GlobalQueueManager {
    @MainActor static let shared = GlobalQueueManager()
    
    var serialQueue = DispatchQueue(label: "jp.star-m.starprntsdk")
}
