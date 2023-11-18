// swift-tools-version:5.8

import PackageDescription

let name = "DieKit"

let package = Package(
    name: name,
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .watchOS(.v4), .tvOS(.v12)
    ],
    products: [
        .library(name: name, targets: [name])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.1"))
    ],
    targets: [
        .target(
            name: name,
            dependencies: [
                .product(name: "Rainbow", package: "Rainbow", condition: .when(platforms: [.macOS])),
            ],
            exclude: ["Info.plist"]
        ),

        .testTarget(
            name: "\(name)Tests",
            dependencies: [.byName(name: name)]
        )
    ]
)
