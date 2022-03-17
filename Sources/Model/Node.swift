//
//  File.swift
//  
//
//  Created by Jeff Lett on 3/9/22.
//

import Foundation

public struct Node: Hashable, CustomStringConvertible {

    public let name: String

    public init(name: String) {
        self.name = name
    }

    public var description: String {
        "\(name)"
    }
    
}
