// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeGraphViz",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser",
                 .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/tuist/XcodeProj.git",
                .upToNextMajor(from: "8.7.1")),
    ],
    targets: [
        .executableTarget(
            name: "XcodeGraphViz",
            dependencies: [
                "Commands"
            ]),
        .target(
            name: "Commands",
            dependencies: [
                "XcodeGraphVizKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
            name: "Model"
        ),
        .target(
            name: "XcodeGraphVizKit",
            dependencies: [
                "Model",
                "XcodeProj",
            ]),
        /* Tests */
        .target(
            name: "TestSupport"),
        .testTarget(
            name: "XcodeGraphVizTests",
            dependencies: [
                "XcodeGraphViz",
                "TestSupport"
            ],
            resources: [
                .copy("Resources/ReactiveSwift"),
                .copy("Resources/TestApp"),
                .copy("Resources/CocoapodsExample"),
            ]
        ),
    ]
)
