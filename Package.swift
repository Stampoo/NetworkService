// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkService",
    products: [
        .library(name: "NetworkService", targets: ["NetworkService"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "NetworkService", dependencies: []),
        .testTarget(name: "NetworkServiceTests", dependencies: ["NetworkService"])
    ]
)

