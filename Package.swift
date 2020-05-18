// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSPRTVideoPlayer",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "NSPRTVideoPlayer",
            targets: ["NSPRTVideoPlayer"]),
    ],
    targets: [
        .target(
            name: "NSPRTVideoPlayer",
            dependencies: []),
        .testTarget(
            name: "NSPRTVideoPlayerTests",
            dependencies: ["NSPRTVideoPlayer"]),
    ]
)
