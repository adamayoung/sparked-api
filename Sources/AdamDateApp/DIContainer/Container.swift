//
//  Container.swift
//  AdamDateApp
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
        guard services[serviceName] == nil else {
            fatalError("\(serviceName) already register in container.")
        }

        services[serviceName] = service
    }

    func resolve<Service>(_ type: Service.Type, name: String? = nil) -> Service {
        let serviceName = Self.serviceName(for: type, name: name)

        guard let serviceBuilder = services[serviceName] else {
            fatalError("\(serviceName) not registered in container.")
        }

        guard let service = serviceBuilder(self) as? Service else {
            fatalError("\(serviceName) registered in container but returned an invalid type.")
        }

        return service
    }

    func configure(with configurator: some ContainerConfigurator) {
        configurator.configure(in: self)
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
