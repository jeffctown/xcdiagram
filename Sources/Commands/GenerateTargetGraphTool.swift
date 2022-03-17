//
//  GenerateTargetGraphTool.swift
//  
//
//  Created by Jeff Lett on 3/8/22.
//

import ArgumentParser
import Foundation
import XcodeGraphVizKit

@main
public struct GenerateTargetGraphTool: ParsableCommand {

    private enum Error: Swift.Error, CustomStringConvertible {
        case mutuallyExclusiveArguments([String])
        case noProjectOrWorkspaceDeclared
        case projectNotFound(String)
        case workspaceNotFound(String)
        case noProjectOrWorkspaceArgument

        var description: String {
                switch self {
                case .mutuallyExclusiveArguments(let arguments):
                    return arguments
                        .map { "'\($0)'" }
                        .joined(separator: " and ") + " are mutually exclusive arguments.  Please only use one at a time."
                case .noProjectOrWorkspaceDeclared:
                    return "no project or workspace declared.  Please add either a --workspace or --project argument."
                case .projectNotFound(let projectPath):
                    return "project not found at path: \(projectPath)"
                case .workspaceNotFound(let workspacePath):
                    return "workspace not found at path: \(workspacePath)"
                case .noProjectOrWorkspaceArgument:
                    return "no project or workspace argument found.  Please indicate which Xcode project or workspace you want to analyze."
                }

        }
    }

    @Flag(help: "Enable verbose logging. Disabled by default.")
    var verbose = false

    @Option(help: "The Xcode project to use to create a dependency graph.")
    var project: String?

    @Option(help: "The Xcode workspace to use to create a dependency graph.")
    var workspace: String?

    public init()  {}

    public func run() throws {
        try postProcessArguments()
        print("Running...")
        if let project = self.project {
            print(try TargetGraphGenerator(project: project).generate())
        } else if let workspace = self.workspace {
            print(try TargetGraphGenerator(project: workspace).generate())
        } else {
            throw Error.noProjectOrWorkspaceDeclared
        }
    }

    func postProcessArguments() throws {
        if project != nil && workspace != nil {
            throw Error.mutuallyExclusiveArguments(["project", "workspace"])
        }
    }
}

/*

 */
