//
//  Graph.swift
//  
//
//  Created by Jeff Lett on 3/9/22.
//

import Foundation

public class Graph: CustomStringConvertible {

    private var nodes = [Node]()
    private var edges = [[Edge]]()
    private var indices = [Node: Int]()

    public init() {}

    public func add(edge: Edge) {
        guard let index = indices[edge.from] else { return }
        edges[index].append(edge)
    }

    public func add(node: Node) -> Node {
        indices[node] = nodes.count
        nodes.append(node)
        edges.append([Edge]())
        return node
    }

    public func neighbors(node: Node) -> [Node] {
        guard let index = index(of: node) else { return [] }
        return edges[index].map { $0.to }
    }

    public func index(of node: Node) -> Int? {
        indices[node]
    }

    public func contains(node: Node) -> Bool {
        index(of: node) != nil
    }

    public var description: String {
        nodes.map { "\($0) -> \(neighbors(node: $0))" }
            .joined(separator: "\n")
    }

    public var dotDescription: String {
        """
        digraph DependenciesGraph {
        node [shape = box]\n
        """ +
        nodes.map { node in
            neighbors(node: node).map { neighbor in
                "\"\(node)\" -> \"\(neighbor)\""
            }.joined(separator: "\n")
        }.filter {
            $0.count > 0
        }.joined(separator: "\n") +
        "\n}"
    }

}
