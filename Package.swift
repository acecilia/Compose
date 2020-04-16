// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Compose",
    products: [
        .library(name: "Compose", targets: ["Compose"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Compose",
            dependencies: []
        ),
        .testTarget(
            name: "ComposeTests",
            dependencies: ["Compose"]
        ),
    ]
)
