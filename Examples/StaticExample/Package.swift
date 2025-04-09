// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "StaticExample",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "StaticExample",
            targets: ["StaticExample"]
        )
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .executableTarget(
            name: "StaticExample",
            dependencies: [
                .product(name: "ElementaryCSS", package: "elementary-css")
            ]
        )
    ]
)
