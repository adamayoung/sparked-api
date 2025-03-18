//
//  ProfileDTOMapper.swift
//  AdamDateApp
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
        profilePhotos: [(ProfilePhoto, URL)],
        interests: [(ProfileInterest, Interest)]
    ) -> ProfileDTO {
        let profilePhotoDTOs = profilePhotos.map(ProfilePhotoDTOMapper.map)
        let interestDTOs = interests.map(ProfileInterestDTOMapper.map)

        return ProfileDTO(
            id: basicProfile.id,
            userID: basicProfile.userID,
            displayName: basicProfile.displayName,
            birthDate: basicProfile.birthDate,
            age: basicProfile.age,
            genderID: basicInfo.genderID,
            countryID: basicInfo.countryID,
            location: basicInfo.location,
            homeTown: basicInfo.homeTown,
            workplace: basicInfo.workplace,
            photos: profilePhotoDTOs,
            interests: interestDTOs
        )
    }

}
