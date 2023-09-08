// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "TextureBridging",
  platforms: [
    .iOS(.v11),
  ],
  products: [
    .library(name: "TextureBridging", targets: ["TextureBridging"]),
  ],
  dependencies: [
    .package(url: "https://github.com/FluidGroup/Texture.git", from: "3.0.2"),
  ],
  targets: [
    .target(
      name: "TextureBridging",
      dependencies: [
        .product(name: "AsyncDisplayKit", package: "Texture"),
      ],
      path: "TextureBridging"
    ),
  ],
  swiftLanguageVersions: [.v5]
)
