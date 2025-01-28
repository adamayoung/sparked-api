// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdamDateApp",

    platforms: [
        .macOS(.v14)
    ],

    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.99.3"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.4.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0")
    ],

    targets: [
        .executableTarget(
            name: "AdamDateApp",
            dependencies: [
                "AdamDateCommands",
                "ProfileAPI",
                "ProfileEntities",
                "ProfileDomain",
                "ProfileData",
                "IdentityAPI",
                "IdentityEntities",
                "IdentityDomain",
                "IdentityData",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver")
            ]
        ),
        .testTarget(
            name: "AdamDateAppTests",
            dependencies: ["AdamDateApp"]
        ),

        .target(
            name: "AdamDateCommands",
            dependencies: [
                "ProfileEntities",
                "ProfileDomain",
                "IdentityEntities",
                "IdentityDomain",
                .product(name: "Vapor", package: "vapor")
            ]
        ),

        // --------------------------------------
        // Profile

        .target(
            name: "ProfileAPI",
            dependencies: [
                "ProfileDomain",
                "ProfileEntities",
                "IdentityEntities",
                "AdamDateAuth",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "ProfileAPITests",
            dependencies: ["ProfileAPI"]
        ),

        .target(
            name: "ProfileEntities"
        ),
        .testTarget(
            name: "ProfileEntitiesTests",
            dependencies: ["ProfileEntities"]
        ),

        .target(
            name: "ProfileDomain",
            dependencies: ["ProfileEntities"]
        ),
        .testTarget(
            name: "ProfileDomainTests",
            dependencies: ["ProfileDomain"]
        ),

        .target(
            name: "ProfileData",
            dependencies: [
                "ProfileDomain",
                .product(name: "Fluent", package: "fluent")
            ]
        ),
        .testTarget(
            name: "ProfileDataTests",
            dependencies: ["ProfileData"]
        ),

        // --------------------------------------
        // User

        .target(
            name: "IdentityAPI",
            dependencies: [
                "IdentityDomain",
                "IdentityEntities",
                "AdamDateAuth",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "IdentityAPITests",
            dependencies: ["IdentityAPI"]
        ),

        .target(name: "IdentityEntities"),
        .testTarget(
            name: "IdentityEntitiesTests",
            dependencies: [
                "IdentityEntities"
            ]
        ),

        .target(
            name: "IdentityDomain",
            dependencies: ["IdentityEntities"]
        ),
        .testTarget(
            name: "IdentityDomainTests",
            dependencies: ["IdentityDomain"]
        ),

        .target(
            name: "IdentityData",
            dependencies: [
                "IdentityDomain",
                .product(name: "Fluent", package: "fluent")
            ]
        ),
        .testTarget(
            name: "IdentityDataTests",
            dependencies: ["IdentityData"]
        ),

        // --------------------------------------
        // Auth

        .target(
            name: "AdamDateAuth",
            dependencies: [.product(name: "JWT", package: "jwt")]
        ),
        .testTarget(
            name: "AdamDateAuthTests",
            dependencies: ["AdamDateAuth"]
        )

    ]
)
