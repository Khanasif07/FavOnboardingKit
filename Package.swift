// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavOnboarfingKit",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FavOnboarfingKit",
            targets: ["FavOnboarfingKit"]),
    ],
    dependencies: [.package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.1")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FavOnboarfingKit",dependencies: ["SnapKit"]),
        .testTarget(
            name: "FavOnboarfingKitTests",
            dependencies: ["FavOnboarfingKit"]),
    ]
)
