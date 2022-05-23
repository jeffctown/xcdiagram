//
//  TargetGraphGenerator.swift
//  
//
//  Created by Jeff Lett on 3/9/22.
//

import Foundation
import Model
import PathKit
import XcodeProj

public class TargetGraphGenerator {

    private let projects: [XcodeProj]

    public init(project: String) throws {
        self.projects = [try XcodeProj(pathString: project)]
    }

    public init(workspace: String) throws {
        let folderPath = NSString(string: workspace).deletingLastPathComponent
        let workspaceData = try XCWorkspaceData(path: Path(workspace + "/contents.xcworkspacedata"))
        self.projects = workspaceData.children.reduce(into: [XcodeProj](), { projects, workspaceElement in
            if case let .file(workspaceGroup) = workspaceElement {
                let projectPath = folderPath + "/" + workspaceGroup.location.path
                print(projectPath)
                if let project = try? XcodeProj(pathString: projectPath) {
                    projects.append(project)
                }
            }
        })
    }

    public func generate() -> String {
        let graph = Graph()
        self.projects.forEach { $0.populateIn(graph: graph) }
        return graph.dotDescription
    }
}

extension String {
    var isSystemFramework: Bool {
        return self.contains("System/Library/Frameworks")
    }
}

extension XcodeProj {

    func populateIn(graph: Graph) {
        self.pbxproj.projects.forEach { project in
            project.targets.forEach { target in
                if let productName = target.productName {
                    var targetNode = Node(name: productName)
                    if !graph.contains(node: targetNode) {
                        targetNode = graph.add(node: targetNode)
                    }
                    target.buildPhases.forEach { buildPhase in
                        if buildPhase.buildPhase == .frameworks {
                            buildPhase.files?.forEach { file in
                                if var path = file.file?.path {
                                    path = path.replacingOccurrences(of: ".framework", with: "")
                                    guard !path.isSystemFramework else {
                                        return
                                    }
                                    let node = Node(name: path)
                                    if !graph.contains(node: node) {
                                        _ = graph.add(node: node)
                                    }
                                    print("Frameworks Build Phase: \(targetNode.name) -> \(node.name)")
                                    graph.add(edge: Edge(from: targetNode, to: node))
                                }
                            }
                        }
                    }
                    target.dependencies.forEach { dependency in
                        guard let name = dependency.target?.productName else {
                            print("No Name");
                            return
                        }
                        let node = Node(name: name)
                        if !graph.contains(node: node) {
                            _ = graph.add(node: node)
                        }
                        graph.add(edge: Edge(from: targetNode, to: node))
                        print("Dependency: \(targetNode.name) -> \(node.name)")
                    }
                }
            }
        }
    }
}
