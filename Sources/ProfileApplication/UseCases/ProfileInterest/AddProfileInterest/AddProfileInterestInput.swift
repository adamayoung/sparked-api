//
//  AddProfileInterestInput.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package struct AddProfileInterestInput: Equatable, Sendable {

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
