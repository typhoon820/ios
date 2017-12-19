//
//  SourceInfoParser.swift
//  Bash-feed
//
//  Created by xcode on 12.12.2017.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation

protocol SourceInfoProtocol {
    var name: String? {get}
    var url: String {get}
    var isEnabled: Bool {get}
    
}
struct SourceInfo: SourceInfoProtocol {
    var name: String?
    var url: String
    var isEnabled: Bool
}

protocol SourceInfoParserProtocol{
    func parse(data: Data) throws -> SourceInfoProtocol
}


