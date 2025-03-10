//
//  PhotoController.swift
//  AdamDateApp
//
//  Created by Adam Young on 21/02/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct PhotoController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", "photos", use: index)
        routes.get(":profileID", "photos", ":photoID", "image", use: showImage)
        routes.post("me", "photos", use: addPhoto)
    }

    @Sendable
    func index(req: Request) async throws -> [ProfilePhotoResponseModel] {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(userID: userID)
        let profilePhotoDTOs = try await req.fetchProfilePhotosUseCase.execute(
            profileID: basicProfileDTO.id
        )

        let profilePhotoResponseModels = profilePhotoDTOs.map(ProfilePhotoResponseModelMapper.map)

        return profilePhotoResponseModels
    }

    @Sendable
    func showImage(req: Request) async throws -> Response {
        try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString),
            let photoIDString = req.parameters.get("photoID", as: String.self),
            let photoID = UUID(uuidString: photoIDString)
        else {
            throw Abort(.notFound)
        }

        _ = try await req.fetchBasicProfileUseCase.execute(id: profileID)
        let profilePhotoDTO = try await req.fetchProfilePhotoUseCase.execute(id: photoID)

        guard profilePhotoDTO.isLocalFile else {
            throw Abort(.notFound)
        }

        return req.fileio.streamFile(at: profilePhotoDTO.url.absoluteString)
    }

    @Sendable
    func addPhoto(req: Request) async throws -> HTTPResponseStatus {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(userID: userID)

        guard let byteBuffer = req.body.data else {
            throw Abort(.badRequest)
        }

        let data = Data(buffer: byteBuffer)
        let input = AddProfilePhotoInput(
            profileID: basicProfileDTO.id,
            photoData: data,
            photoType: "jpg"
        )

        _ = try await req.addProfilePhotoUseCase.execute(input: input)

        return .created
    }

}
