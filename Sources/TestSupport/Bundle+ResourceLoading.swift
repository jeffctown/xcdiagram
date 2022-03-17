//
//  Bundle+ResourceLoading.swift
//  
//
//  Created by Jeff Lett on 3/9/22.
//

import Foundation
import XCTest

public extension Bundle {
    func unitTestDirectoryPathURL(path: String) -> URL? {
        url(forResource: path, withExtension: "")
    }

    func unitTestDirectoryPath(path: String) throws -> String {
        try XCTUnwrap(unitTestDirectoryPathURL(path: path)).path
    }
}
