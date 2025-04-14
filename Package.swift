// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SparkedAPI",

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
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/swift-prometheus.git", from: "2.1.0")
    ],

    targets: [
        .executableTarget(
            name: "SparkedAPI",
            dependencies: [
                "SparkedCommands",
                "HealthWebAPI",
                "MetricsWebAPI",
                "ProfileWebAPI",
                "ProfileApplication",
                "ProfileInfrastructure",
                "ProfileDomain",
                "ReferenceDataWebAPI",
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
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Prometheus", package: "swift-prometheus")
            ]
        ),
        .testTarget(
            name: "SparkedAPITests",
            dependencies: ["SparkedAPI"]
        ),

        .target(
            name: "SparkedCommands",
            dependencies: [
                "ProfileApplication",
                "IdentityApplication",
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
            ],
            path: "Sources/Profile/ProfileWebAPI"
        ),
        .testTarget(
            name: "ProfileWebAPITests",
            dependencies: [
                "ProfileWebAPI",
                "ProfileApplication",
                "APITestingSupport",
                .product(name: "VaporTesting", package: "vapor")
            ],
            path: "Tests/Profile/ProfileWebAPITests"
        ),

        .target(
            name: "ProfileApplication",
            dependencies: ["ProfileDomain"],
            path: "Sources/Profile/ProfileApplication"
        ),
        .testTarget(
            name: "ProfileApplicationTests",
            dependencies: [
                "ProfileApplication",
                "ProfileDomain"
            ],
            path: "Tests/Profile/ProfileApplicationTests"
        ),

        .target(
            name: "ProfileInfrastructure",
            dependencies: [
                "ProfileApplication",
                "ProfileDomain",
                .product(name: "Fluent", package: "fluent")
            ],
            path: "Sources/Profile/ProfileInfrastructure"
        ),
        .testTarget(
            name: "ProfileInfrastructureTests",
            dependencies: [
                "ProfileInfrastructure",
                "ProfileApplication",
                "ProfileDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ],
            path: "Tests/Profile/ProfileInfrastructureTests"
        ),

        .target(
            name: "ProfileDomain",
            path: "Sources/Profile/ProfileDomain"
        ),
        .testTarget(
            name: "ProfileDomainTests",
            dependencies: ["ProfileDomain"],
            path: "Tests/Profile/ProfileDomainTests"
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
            ],
            path: "Sources/Identity/IdentityWebAPI"

        ),
        .testTarget(
            name: "IdentityWebAPITests",
            dependencies: [
                "IdentityWebAPI",
                "IdentityApplication",
                "APITestingSupport",
                .product(name: "JWT", package: "jwt"),
                .product(name: "VaporTesting", package: "vapor")
            ],
            path: "Tests/Identity/IdentityWebAPITests"
        ),

        .target(
            name: "IdentityApplication",
            dependencies: ["IdentityDomain"],
            path: "Sources/Identity/IdentityApplication"
        ),
        .testTarget(
            name: "IdentityApplicationTests",
            dependencies: [
                "IdentityApplication",
                "IdentityDomain"
            ],
            path: "Tests/Identity/IdentityApplicationTests"
        ),

        .target(
            name: "IdentityInfrastructure",
            dependencies: [
                "IdentityApplication",
                "IdentityDomain",
                .product(name: "Fluent", package: "fluent")
            ],
            path: "Sources/Identity/IdentityInfrastructure"
        ),
        .testTarget(
            name: "IdentityInfrastructureTests",
            dependencies: [
                "IdentityInfrastructure",
                "IdentityApplication",
                "IdentityDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ],
            path: "Tests/Identity/IdentityInfrastructureTests"
        ),

        .target(
            name: "IdentityDomain",
            path: "Sources/Identity/IdentityDomain"
        ),
        .testTarget(
            name: "IdentityDomainTests",
            dependencies: ["IdentityDomain"],
            path: "Tests/Identity/IdentityDomainTests"
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
            ],
            path: "Sources/ReferenceData/ReferenceDataWebAPI"
        ),
        .testTarget(
            name: "ReferenceDataWebAPITests",
            dependencies: [
                "ReferenceDataWebAPI",
                "ReferenceDataApplication",
                "APITestingSupport",
                .product(name: "JWT", package: "jwt"),
                .product(name: "VaporTesting", package: "vapor")
            ],
            path: "Tests/ReferenceData/ReferenceDataWebAPITests"
        ),

        .target(
            name: "ReferenceDataApplication",
            dependencies: ["ReferenceDataDomain"],
            path: "Sources/ReferenceData/ReferenceDataApplication"
        ),
        .testTarget(
            name: "ReferenceDataApplicationTests",
            dependencies: ["ReferenceDataApplication"],
            path: "Tests/ReferenceData/ReferenceDataApplicationTests"
        ),

        .target(
            name: "ReferenceDataInfrastructure",
            dependencies: [
                "ReferenceDataApplication",
                "ReferenceDataDomain",
                .product(name: "Fluent", package: "fluent")
            ],
            path: "Sources/ReferenceData/ReferenceDataInfrastructure"
        ),
        .testTarget(
            name: "ReferenceDataInfrastructureTests",
            dependencies: [
                "ReferenceDataInfrastructure",
                "ReferenceDataApplication",
                "ReferenceDataDomain",
                .product(name: "Fluent", package: "fluent"),
                .product(name: "XCTFluent", package: "fluent-kit")
            ],
            path: "Tests/ReferenceData/ReferenceDataInfrastructureTests"
        ),

        .target(
            name: "ReferenceDataDomain",
            path: "Sources/ReferenceData/ReferenceDataDomain"
        ),
        .testTarget(
            name: "ReferenceDataDomainTests",
            dependencies: ["ReferenceDataDomain"],
            path: "Tests/ReferenceData/ReferenceDataDomainTests"
        ),

        // --------------------------------------
        // Health

        .target(
            name: "HealthWebAPI",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ],
            path: "Sources/Health/HealthWebAPI"
        ),
        .testTarget(
            name: "HealthWebAPITests",
            dependencies: [
                "HealthWebAPI",
                "APITestingSupport",
                .product(name: "VaporTesting", package: "vapor")
            ],
            path: "Tests/Health/HealthWebAPITests"
        ),

        // --------------------------------------
        // Metrics

        .target(
            name: "MetricsWebAPI",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Prometheus", package: "swift-prometheus")
            ],
            path: "Sources/Metrics/MetricsWebAPI"
        ),
        .testTarget(
            name: "MetricsWebAPITests",
            dependencies: [
                "MetricsWebAPI",
                .product(name: "VaporTesting", package: "vapor")
            ],
            path: "Tests/Metrics/MetricsWebAPITests"
        ),

        // --------------------------------------
        // Infrastructure

        .target(
            name: "AuthKit",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt")
            ],
            path: "Sources/Infrastructure/AuthKit"
        ),
        .testTarget(
            name: "AuthKitTests",
            dependencies: ["AuthKit"],
            path: "Tests/Infrastructure/AuthKitTests"
        ),

        .target(
            name: "CacheKit",
            dependencies: [.product(name: "Logging", package: "swift-log")],
            path: "Sources/Infrastructure/CacheKit"

        ),
        .testTarget(
            name: "CacheKitTests",
            dependencies: ["CacheKit"],
            path: "Tests/Infrastructure/CacheKitTests"
        ),

        .target(
            name: "FileStorageKit",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio")
            ],
            path: "Sources/Infrastructure/FileStorageKit"
        ),
        .testTarget(
            name: "FileStorageKitTests",
            dependencies: ["FileStorageKit"],
            path: "Tests/Infrastructure/FileStorageKitTests"
        ),

        // --------------------------------------
        // Testing Support

        .target(
            name: "APITestingSupport",
            dependencies: [
                "AuthKit",
                .product(name: "VaporTesting", package: "vapor"),
                .product(name: "JWT", package: "jwt")
            ],
            path: "Sources/TestingSupport/APITestingSupport"
        )

    ]
)

#if compiler(>=6)
    for target in package.targets {
        target.swiftSettings = target.swiftSettings ?? []
        target.swiftSettings?.append(contentsOf: [
            .enableExperimentalFeature("StrictConcurrency"),
            .enableUpcomingFeature("ExistentialAny")
        ])
    }
#endif
