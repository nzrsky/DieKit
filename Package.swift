// swift-tools-version:5.3

import PackageDescription

let name = "DieKit"

let package = Package(
    name: name,
	platforms: [
        .macOS(.v10_15), .iOS(.v13), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [.library(name: name, targets: [name])],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.1")),
		//    .package(path: "../CallStackParser")
	],
    targets: [
        .target(
			name: name, 
			dependencies: [
				.product(name: "Rainbow", package: "Rainbow", condition: .when(platforms: [.macOS])),
			],
			path: name
		),
        .target(name: "\(name)Tests", dependencies: [.byName(name: name)], path: "Tests")
    ]
)
