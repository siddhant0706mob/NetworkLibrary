// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkLibrary",
    products: [
        .library(
            name: "NetworkLibrary",
            targets: ["NetworkLibrary"]),
    ],
    targets: [
        .target(
            name: "NetworkLibrary"),
        .testTarget(
            name: "NetworkLibraryTests",
            dependencies: ["NetworkLibrary"]
        ),
    ]
)
