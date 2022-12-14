// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RestaurantsFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RestaurantsFeature",
            targets: ["RestaurantsFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RestaurantsFeature",
            dependencies: []),
        .testTarget(
            name: "RestaurantsFeatureTests",
            dependencies: ["RestaurantsFeature"], resources: [Resource.process("Assets.xcassets")] ),
    ]
)
