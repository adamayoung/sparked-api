//
//  BasicProfileRepository.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileDomain

package protocol BasicProfileRepository: CreateBasicProfileRepository, FetchBasicProfileRepository,
    Sendable
{}
