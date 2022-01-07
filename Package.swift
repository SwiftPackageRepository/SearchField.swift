// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SearchField",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SearchField",
            targets: ["SearchField"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SearchField",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SearchFieldTests",
            dependencies: ["SearchField"]
        ),
    ]
)
