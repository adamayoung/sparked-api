//
//  HealthController.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Vapor

struct HealthController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get(use: index)
            .description("Responds with 200 OK if the application is healthy.")

        routes.get("status", use: status)
            .description("Responds with the current health status of the application.")
    }

    func index(req: Request) async throws -> HTTPStatus {
        let healthStatus = await req.healthService.status()

        guard healthStatus.isHealthy else {
            return .internalServerError
        }

        return .ok
    }

    func status(req: Request) async throws -> Response {
        let healthStatus = await req.healthService.status()

        let healthStatusResponseModel = HealthStatusResponseModelMapper.map(from: healthStatus)

        let response = try await healthStatusResponseModel.encodeResponse(for: req)
        response.status = healthStatus.isHealthy ? .ok : .internalServerError
        return response
    }

}
