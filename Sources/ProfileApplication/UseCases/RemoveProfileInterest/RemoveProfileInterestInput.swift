//
//  RemoveProfileInterestInput.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct RemoveProfileInterestInput: Equatable, Sendable {

    package let profileID: UUID
    package let interestID: UUID

    package init(
        profileID: UUID,
        interestID: UUID
    ) {
        self.profileID = profileID
        self.interestID = interestID
    }

}
