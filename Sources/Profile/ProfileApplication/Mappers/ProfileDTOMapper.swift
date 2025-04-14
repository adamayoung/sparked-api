//
//  ProfileDTOMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileDomain

struct ProfileDTOMapper {

    private init() {}

    static func map(
        from basicProfile: BasicProfile,
        basicInfo: BasicInfo,
        extendedInfo: ExtendedInfo?,
        profilePhotos: [(ProfilePhoto, URL)],
        interestIDs: [UUID]
    ) -> ProfileDTO {
        let profilePhotoDTOs = profilePhotos.map(ProfilePhotoDTOMapper.map)

        return ProfileDTO(
            id: basicProfile.id,
            displayName: basicProfile.displayName,
            birthDate: basicProfile.birthDate,
            age: basicProfile.age,
            genderID: basicInfo.genderID,
            countryID: basicInfo.countryID,
            location: basicInfo.location,
            homeTown: basicInfo.homeTown,
            workplace: basicInfo.workplace,
            photos: profilePhotoDTOs,
            interestIDs: interestIDs,
            height: extendedInfo?.height,
            educationLevelID: extendedInfo?.educationLevelID,
            starSignID: extendedInfo?.starSignID

        )
    }

}
