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
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0"),
        .package(url: "https://github.com/alexsteinerde/graphql-kit.git", from: "3.0.0"),
        .package(url: "https://github.com/alexsteinerde/graphiql-vapor.git", from: "2.4.0")
    ],

    targets: [
        .executableTarget(
            name: "AdamDateApp",
            dependencies: [
                "AdamDateCommands",
                "ProfileWebAPI",
                "ProfileGraphQL",
                "ProfileApplication",
                "ProfileInfrastructure",
                "ProfileDomain",
                "ReferenceDataWebAPI",
                "ReferenceDataGraphQL",
                "ReferenceDataApplication",
                "ReferenceDataInfrastructure",
                "ReferenceDataDomain",
                "IdentityWebAPI",
                "IdentityApplication",
                "IdentityInfrastructure",
                "IdentityDomain",
                "CacheKit",
                "FileStorageKit",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver")
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
            name: "ProfileWebAPI",
            dependencies: [
                "ProfileApplication",
                "AuthKit",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "ProfileWebAPITests",
            dependencies: [
                "ProfileWebAPI",
                "ProfileApplication",
                "APITesting",
                .product(name: "VaporTesting", package: "vapor")
            ]
        ),

        .target(
            name: "ProfileGraphQL",
            dependencies: [
                "ProfileApplication",
                "AuthKit",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "GraphQLKit", package: "graphql-kit"),
                .product(name: "GraphiQLVapor", package: "graphiql-vapor")
            ]
        ),
        .testTarget(
            name: "ProfileGraphQLTests",
            dependencies: [
                "ProfileGraphQL"
            ]
        ),

        .target(
            name: "ProfileApplication",
            dependencies: ["ProfileDomain"]
        ),
        .testTarget(
            name: "ProfileApplicationTests",
            dependencies: [
                "ProfileApplication",
                "ProfileDomain"
            ]
        ),

        .target(
            name: "ProfileInfrastructure",
            dependencies: [
                "ProfileApplication",
                "ProfileDomain",
                .product(name: "Fluent", package: "fluent")
            ]
        ),
        .testTarget(
            name: "ProfileInfrastructureTests",
            dependencies: [
                "ProfileInfrastructure",
                "ProfileApplication",
                "ProfileDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ]
        ),

        .target(name: "ProfileDomain"),
        .testTarget(
            name: "ProfileDomainTests",
            dependencies: ["ProfileDomain"]
        ),

        // --------------------------------------
        // Identity

        .target(
            name: "IdentityWebAPI",
            dependencies: [
                "IdentityApplication",
                "AuthKit",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "IdentityWebAPITests",
            dependencies: [
                "IdentityWebAPI",
                "IdentityApplication",
                "APITesting",
                .product(name: "JWT", package: "jwt"),
                .product(name: "VaporTesting", package: "vapor")
            ]
        ),

        .target(
            name: "IdentityApplication",
            dependencies: ["IdentityDomain"]
        ),
        .testTarget(
            name: "IdentityApplicationTests",
            dependencies: [
                "IdentityApplication",
                "IdentityDomain"
            ]
        ),

        .target(
            name: "IdentityInfrastructure",
            dependencies: [
                "IdentityApplication",
                "IdentityDomain",
                .product(name: "Fluent", package: "fluent")
            ]
        ),
        .testTarget(
            name: "IdentityInfrastructureTests",
            dependencies: [
                "IdentityInfrastructure",
                "IdentityApplication",
                "IdentityDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ]
        ),

        .target(name: "IdentityDomain"),
        .testTarget(
            name: "IdentityDomainTests",
            dependencies: ["IdentityDomain"]
        ),

        // --------------------------------------
        // Reference Data

        .target(
            name: "ReferenceDataWebAPI",
            dependencies: [
                "ReferenceDataApplication",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "ReferenceDataWebAPITests",
            dependencies: [
                "ReferenceDataWebAPI",
                "ReferenceDataApplication",
                "APITesting",
                .product(name: "JWT", package: "jwt"),
                .product(name: "VaporTesting", package: "vapor")
            ]
        ),

        .target(
            name: "ReferenceDataGraphQL",
            dependencies: [
                "ReferenceDataApplication",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "GraphQLKit", package: "graphql-kit"),
                .product(name: "GraphiQLVapor", package: "graphiql-vapor")
            ]
        ),
        .testTarget(
            name: "ReferenceDataGraphQLTests",
            dependencies: [
                "ReferenceDataGraphQL"
            ]
        ),

        .target(
            name: "ReferenceDataApplication",
            dependencies: ["ReferenceDataDomain"]
        ),
        .testTarget(
            name: "ReferenceDataApplicationTests",
            dependencies: ["ReferenceDataApplication"]
        ),

        .target(
            name: "ReferenceDataInfrastructure",
            dependencies: [
                "ReferenceDataApplication",
                "ReferenceDataDomain",
                .product(name: "Fluent", package: "fluent")
            ]
        ),
        .testTarget(
            name: "ReferenceDataInfrastructureTests",
            dependencies: [
                "ReferenceDataInfrastructure",
                "ReferenceDataApplication",
                "ReferenceDataDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ]
        ),

        .target(name: "ReferenceDataDomain"),
        .testTarget(
            name: "ReferenceDataDomainTests",
            dependencies: ["ReferenceDataDomain"]
        ),

        // --------------------------------------
        // Infrastructure

        .target(
            name: "AuthKit",
            dependencies: [.product(name: "JWT", package: "jwt")]
        ),
        .testTarget(
            name: "AuthKitTests",
            dependencies: ["AuthKit"]
        ),

        .target(name: "CacheKit"),
        .testTarget(
            name: "CacheKitTests",
            dependencies: ["CacheKit"]
        ),

        .target(
            name: "FileStorageKit",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "FileStorageKitTests",
            dependencies: ["FileStorageKit"]
        ),

        // --------------------------------------
        // Testing Support

        .target(
            name: "APITesting",
            dependencies: [
                "AuthKit",
                .product(name: "VaporTesting", package: "vapor"),
                .product(name: "JWT", package: "jwt")
            ]
        )

    ]
)
