//
//  PhotoController.swift
//  SparkedAPI
//
//  Created by Adam Young on 21/02/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct PhotoController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("me", "photos") { mePhotos in
            mePhotos.get(use: meIndex)
                .description("Get all photos for the authenticated user")

            mePhotos.post(use: addPhoto)
                .description("Add a photo for the authenticated user")
        }

        routes.group(":profileID", "photos") { photos in
            photos.get(use: index)
                .description("Get all photos for a given profile")

            photos.get(":photoID", use: show)
                .description("Get a photo for a given profile")

            photos.patch(":photoID", use: patch)
                .description("Update a photo for a given profile")

            photos.delete(":photoID", use: delete)
                .description("Delete a photo for a given profile")

            photos.get(":photoID", "image", use: showImage)
                .description("Get an image for a given photo")
        }
    }

    @Sendable
    func index(req: Request) async throws -> [ProfilePhotoResponseModel] {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            id: profileID,
            userContext: userContext
        )
        let profilePhotoDTOs = try await req.fetchProfilePhotosUseCase.execute(
            profileID: basicProfileDTO.id,
            userContext: userContext
        )

        let profilePhotoResponseModels = profilePhotoDTOs.map {
            ProfilePhotoResponseModelMapper.map(from: $0, profileID: basicProfileDTO.id)
        }

        return profilePhotoResponseModels
    }

    @Sendable
    func meIndex(req: Request) async throws -> [ProfilePhotoResponseModel] {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        let profilePhotoDTOs = try await req.fetchProfilePhotosUseCase.execute(
            profileID: basicProfileDTO.id,
            userContext: userContext
        )

        let profilePhotoResponseModels = profilePhotoDTOs.map {
            ProfilePhotoResponseModelMapper.map(from: $0, profileID: basicProfileDTO.id)
        }

        return profilePhotoResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> ProfilePhotoResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString),
            let photoIDString = req.parameters.get("photoID", as: String.self),
            let photoID = UUID(uuidString: photoIDString)
        else {
            throw Abort(.notFound)
        }

        _ = try await req.fetchBasicProfileUseCase.execute(
            id: profileID,
            userContext: userContext
        )

        let profilePhotoDTO = try await req.fetchProfilePhotoUseCase.execute(
            id: photoID,
            userContext: userContext
        )

        let profilePhotoResponseModel = ProfilePhotoResponseModelMapper.map(
            from: profilePhotoDTO,
            profileID: profileID
        )

        return profilePhotoResponseModel
    }

    @Sendable
    func showImage(req: Request) async throws -> Response {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString),
            let photoIDString = req.parameters.get("photoID", as: String.self),
            let photoID = UUID(uuidString: photoIDString)
        else {
            throw Abort(.notFound)
        }

        _ = try await req.fetchBasicProfileUseCase.execute(
            id: profileID,
            userContext: userContext
        )
        let profilePhotoDTO = try await req.fetchProfilePhotoUseCase.execute(
            id: photoID,
            userContext: userContext
        )

        guard profilePhotoDTO.isLocalFile else {
            throw Abort(.notFound)
        }

        return req.fileio.streamFile(at: profilePhotoDTO.url.absoluteString)
    }

    @Sendable
    func patch(req: Request) async throws -> ProfilePhotoResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString),
            let photoIDString = req.parameters.get("photoID", as: String.self),
            let photoID = UUID(uuidString: photoIDString)
        else {
            throw Abort(.notFound)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        guard basicProfileDTO.id == profileID else {
            throw Abort(.forbidden)
        }

        let patchProfilePhotoIndexRequestModel: PatchProfilePhotoIndexRequestModel
        do {
            patchProfilePhotoIndexRequestModel = try req.content
                .decode(PatchProfilePhotoIndexRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = ChangeProfilePhotoOrderInputMapper.map(
            profileID: basicProfileDTO.id,
            photoID: photoID,
            newIndex: patchProfilePhotoIndexRequestModel.index
        )

        let profilePhotoDTO = try await req.changeProfilePhotoOrderUseCase.execute(
            input: input,
            userContext: userContext
        )
        let profilePhotoResponseModel = ProfilePhotoResponseModelMapper.map(
            from: profilePhotoDTO,
            profileID: basicProfileDTO.id
        )

        return profilePhotoResponseModel
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPResponseStatus {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString),
            let photoIDString = req.parameters.get("photoID", as: String.self),
            let photoID = UUID(uuidString: photoIDString)
        else {
            throw Abort(.notFound)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        guard basicProfileDTO.id == profileID else {
            throw Abort(.forbidden)
        }

        let input = DeleteProfilePhotoInput(profileID: basicProfileDTO.id, photoID: photoID)
        try await req.deleteProfilePhotoUseCase.execute(input: input, userContext: userContext)

        return .accepted
    }

    @Sendable
    func addPhoto(req: Request) async throws -> HTTPResponseStatus {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )

        guard let byteBuffer = req.body.data else {
            throw Abort(.badRequest)
        }

        let data = Data(buffer: byteBuffer)
        let input = AddProfilePhotoInput(
            profileID: basicProfileDTO.id,
            photoData: data,
            photoType: "jpg"
        )

        _ = try await req.addProfilePhotoUseCase.execute(input: input, userContext: userContext)

        return .created
    }

}
