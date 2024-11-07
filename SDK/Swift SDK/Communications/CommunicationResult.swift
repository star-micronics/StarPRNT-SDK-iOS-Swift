//
//  CommunicationResult.swift
//  Swift SDK
//
//  Copyright © 2019 Star Micronics. All rights reserved.
//

import Foundation

struct CommunicationResult: Sendable {
    let result: Result
    let code: Int
    
    init(_ result: Result, _ code: Int) {
        self.result = result
        self.code = code
    }
}

enum Result: Sendable {
    case success
    case errorOpenPort
    case errorBeginCheckedBlock
    case errorEndCheckedBlock
    case errorWritePort
    case errorReadPort
    case errorUnknown
}
