//
//  File.swift
//  
//
//  Created by Jeff Lett on 3/9/22.
//

import Foundation

public struct Edge: CustomStringConvertible {

    public let from: Node
    public let to: Node

    public init(from: Node, to: Node) {
        self.from = from
        self.to = to
    }

    public var description: String {
        "\(from) -> \(to)"
    }
    
}
