//
//  Container.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

class Container: @unchecked Sendable {

    private var services: [String: (Container) -> Any] = [:]

    init() {
        setup()
    }

    func setup() {}

    func register<Service>(
        type: Service.Type,
        name: String? = nil,
        service: @escaping (Container) -> Service
    ) {
        let serviceName = Self.serviceName(for: type, name: name)
        services[serviceName] = service
    }

    func resolve<Service>(_ type: Service.Type, name: String? = nil) -> Service {
        let serviceName = Self.serviceName(for: type, name: name)

        guard let serviceBuilder = services[serviceName] else {
            fatalError("Container not registered for \(serviceName).")
        }

        guard let service = serviceBuilder(self) as? Service else {
            fatalError("Container registered for \(serviceName) but returned an invalid type.")
        }

        return service
    }

}

extension Container {

    private static func serviceName<Service>(for type: Service.Type, name: String?) -> String {
        guard let name else {
            return "\(type)"
        }

        return "\(type)-\(name)"
    }

}
