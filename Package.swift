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
        //        .package(url: "https://github.com/vapor/leaf.git", from: "4.4.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-kit.git", from: "1.49.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0")
    ],

    targets: [
        .executableTarget(
            name: "AdamDateApp",
            dependencies: [
                "AdamDateCommands",
                "ProfileAPI",
                "ProfileDomain",
                "ProfileInfrastructure",
                "IdentityAPI",
                "IdentityDomain",
                "IdentityInfrastructure",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt"),
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
                "ProfileDomain",
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
                "AdamDateAuth",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "ProfileAPITests",
            dependencies: [
                "ProfileAPI",
                "ProfileDomain",
                "APITesting",
                .product(name: "VaporTesting", package: "vapor")
            ]
        ),

        .target(name: "ProfileDomain"),
        .testTarget(
            name: "ProfileDomainTests",
            dependencies: ["ProfileDomain"]
        ),

        .target(
            name: "ProfileInfrastructure",
            dependencies: [
                "ProfileDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ]
        ),
        .testTarget(
            name: "ProfileInfrastructureTests",
            dependencies: ["ProfileInfrastructure"]
        ),

        // --------------------------------------
        // User

        .target(
            name: "IdentityAPI",
            dependencies: [
                "IdentityDomain",
                "AdamDateAuth",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "IdentityAPITests",
            dependencies: [
                "IdentityAPI",
                "IdentityDomain",
                "APITesting",
                .product(name: "JWT", package: "jwt"),
                .product(name: "VaporTesting", package: "vapor")
            ]
        ),

        .target(name: "IdentityDomain"),
        .testTarget(
            name: "IdentityDomainTests",
            dependencies: ["IdentityDomain"]
        ),

        .target(
            name: "IdentityInfrastructure",
            dependencies: [
                "IdentityDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ]
        ),
        .testTarget(
            name: "IdentityInfrastructureTests",
            dependencies: ["IdentityInfrastructure"]
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
        ),

        // --------------------------------------
        // Testing Support

        .target(
            name: "APITesting",
            dependencies: [
                "AdamDateAuth",
                .product(name: "VaporTesting", package: "vapor"),
                .product(name: "JWT", package: "jwt")
            ]
        )

    ]
)
