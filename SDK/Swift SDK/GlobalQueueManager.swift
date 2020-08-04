//
//  GlobalQueueManager.swift
//  Swift SDK
//
//  Created by u3237 on 2017/05/31.
//  Copyright © 2017 Star Micronics. All rights reserved.
//

import Foundation

class GlobalQueueManager {
    static let shared = GlobalQueueManager()
    
    var serialQueue = DispatchQueue(label: "jp.star-m.swiftsdk")
}
