// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Movie",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "Movie",
            targets: ["Movie"]),
    ],
    dependencies: [
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.2.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
        .package(name: "Core", url: "https://github.com/emresutisna/Core.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Movie",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
                "Core",
                "Alamofire"
            ]),
        .testTarget(
            name: "MovieTests",
            dependencies: ["Movie"]),
    ]
)
