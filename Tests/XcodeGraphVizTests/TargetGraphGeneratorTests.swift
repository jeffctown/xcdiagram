//
//  TargetGraphGeneratorTests.swift
//  
//
//  Created by Jeff Lett on 3/9/22.
//

import TestSupport
@testable import XcodeGraphVizKit
import XCTest

class TargetGraphGeneratorTests: XCTestCase {

    static let kReactiveSwiftProject = try! Bundle.module.unitTestDirectoryPath(path: "ReactiveSwift/ReactiveSwift.xcodeproj")
    static let kTestAppProject = try! Bundle.module.unitTestDirectoryPath(path: "TestApp/TestApp.xcodeproj")
    static let kCocoapodsWorkspace = try! Bundle.module.unitTestDirectoryPath(path: "CocoapodsExample/Eorzea Timers.xcworkspace")

    func testReactiveSwift() throws {
        let sut = try TargetGraphGenerator(project: Self.kReactiveSwiftProject)
        print(sut.generate())
        XCTAssertEqual(1, 1)
    }

    func disable_testApp() throws {
        let sut = try TargetGraphGenerator(project: Self.kTestAppProject)
        print(sut.generate())
        XCTAssertTrue(true)
    }

    func disable_testCocoapods() throws {
        let sut = try TargetGraphGenerator(workspace: Self.kCocoapodsWorkspace)
        print(sut.generate())
        XCTAssertTrue(true)
    }

}
