//
//  MetricsController.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Metrics
import Prometheus
import Vapor

struct MetricsController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get(use: index)
            .description("Returns metrics.")
    }

    func index(req: Request) async throws -> String {
        let result = Task(priority: .background) {
            try MetricsSystem.prometheus.emit()
        }

        return try await result.value
    }

}

extension MetricsSystem {

    static var prometheus: PrometheusMetricsFactory {
        get throws {
            guard let factory = Self.factory as? PrometheusMetricsFactory else {
                throw Abort(.internalServerError, reason: "Metrics factory is not Prometheus")
            }
            return factory
        }
    }

}

extension PrometheusMetricsFactory {

    func emit() -> String {
        var buffer: [UInt8] = []
        self.registry.emit(into: &buffer)
        return String(bytes: buffer, encoding: .utf8) ?? ""
    }

}
