//
//  CommunicationResult.swift
//  Swift SDK
//
//  Copyright © 2019 Star Micronics. All rights reserved.
//

import Foundation

class CommunicationResult {
    var result: Result
    var code: Int
    
    init(_ result: Result, _ code: Int) {
        self.result = result
        self.code = code
    }
}

enum Result {
    case success
    case errorOpenPort
    case errorBeginCheckedBlock
    case errorEndCheckedBlock
    case errorWritePort
    case errorReadPort
    case errorUnknown
}
