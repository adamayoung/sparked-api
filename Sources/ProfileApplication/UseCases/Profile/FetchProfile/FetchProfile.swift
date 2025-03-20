//
//  FetchProfile.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileDomain

final class FetchProfile: FetchProfileUseCase {

    private let basicProfileRepository: any BasicProfileRepository
    private let basicInfoRepository: any BasicInfoRepository
    private let extendedInfoRepository: any ExtendedInfoRepository
    private let profilePhotoRepository: any ProfilePhotoRepository
    private let imageRepository: any ImageRepository
    private let profileInterestRepository: any ProfileInterestRepository
    private let interestRepository: any InterestRepository

    init(
        basicProfileRepository: some BasicProfileRepository,
        basicInfoRepository: some BasicInfoRepository,
        extendedInfoRepository: some ExtendedInfoRepository,
        profilePhotoRepository: some ProfilePhotoRepository,
        imageRepository: some ImageRepository,
        profileInterestRepository: some ProfileInterestRepository,
        interestRepository: some InterestRepository
    ) {
        self.basicProfileRepository = basicProfileRepository
        self.basicInfoRepository = basicInfoRepository
        self.extendedInfoRepository = extendedInfoRepository
        self.profilePhotoRepository = profilePhotoRepository
        self.imageRepository = imageRepository
        self.profileInterestRepository = profileInterestRepository
        self.interestRepository = interestRepository
    }

    func execute(
        id: UUID,
        userContext: some UserContext
    ) async throws(FetchProfileError) -> ProfileDTO {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: id)
        } catch BasicProfileRepositoryError.notFound {
            throw .notFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        let basicInfo = try await basicInfo(forProfileID: basicProfile.id)
        let extendedInfo = try await extendedInfo(forProfileID: basicProfile.id)

        guard
            userContext.canRead(ownerID: basicProfile.ownerID),
            userContext.canRead(ownerID: basicInfo.ownerID)
        else {
            throw .unauthorized
        }

        if let extendedInfo, !userContext.canRead(ownerID: extendedInfo.ownerID) {
            throw .unauthorized
        }

        let profilePhotosWithURLs = try await profilePhotosWithURLs(forProfileID: basicProfile.id)
        let interestIDs = try await interestIDs(forProfileID: basicProfile.id)
        let profileDTO = ProfileDTOMapper.map(
            from: basicProfile,
            basicInfo: basicInfo,
            extendedInfo: extendedInfo,
            profilePhotos: profilePhotosWithURLs,
            interestIDs: interestIDs
        )

        return profileDTO
    }

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchProfileError) -> ProfileDTO {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byUserID: userID)
        } catch BasicProfileRepositoryError.notFound {
            throw .userNotFound(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        let basicInfo = try await basicInfo(forProfileID: basicProfile.id)
        let extendedInfo = try await extendedInfo(forProfileID: basicProfile.id)

        guard
            userContext.canRead(ownerID: basicProfile.ownerID),
            userContext.canRead(ownerID: basicInfo.ownerID)
        else {
            throw .unauthorized
        }

        if let extendedInfo, !userContext.canRead(ownerID: extendedInfo.ownerID) {
            throw .unauthorized
        }

        guard
            userContext.isOwner(basicInfo.ownerID)
                || (userContext.isAdmin && userContext.isSystem)
        else {
            throw .unauthorized
        }

        let profilePhotosWithURLs = try await profilePhotosWithURLs(forProfileID: basicProfile.id)
        let interestIDs = try await interestIDs(forProfileID: basicProfile.id)
        let profileDTO = ProfileDTOMapper.map(
            from: basicProfile,
            basicInfo: basicInfo,
            extendedInfo: extendedInfo,
            profilePhotos: profilePhotosWithURLs,
            interestIDs: interestIDs
        )

        return profileDTO
    }

}

extension FetchProfile {

    private func basicInfo(
        forProfileID profileID: UUID
    ) async throws(FetchProfileError) -> BasicInfo {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await basicInfoRepository.fetch(byProfileID: profileID)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        return basicInfo
    }

    private func extendedInfo(
        forProfileID profileID: UUID
    ) async throws(FetchProfileError) -> ExtendedInfo? {
        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try await extendedInfoRepository.fetch(byProfileID: profileID)
        } catch ExtendedInfoRepositoryError.notFound {
            return nil
        } catch let error {
            throw .unknown(error)
        }

        return extendedInfo
    }

    private func profilePhotosWithURLs(
        forProfileID profileID: UUID
    ) async throws(FetchProfileError) -> [(ProfilePhoto, URL)] {
        let profilePhotos: [ProfilePhoto]
        do {
            profilePhotos = try await profilePhotoRepository.fetchAll(forProfileID: profileID)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .notFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        var results: [(ProfilePhoto, URL)] = []
        do {
            for profilePhoto in profilePhotos {
                let url = try await imageRepository.url(for: profilePhoto.filename)
                results.append((profilePhoto, url))
            }
        } catch let error {
            throw .unknown(error)
        }

        return results
    }

    private func interestIDs(
        forProfileID profileID: UUID
    ) async throws(FetchProfileError) -> [UUID] {
        let profileInterests: [ProfileInterest]
        do {
            profileInterests = try await profileInterestRepository.fetchAll(forProfileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        let ids = profileInterests.map(\.id)

        return ids
    }

}
