//
//  ImageRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

package protocol ImageRemoteDataSource {

    func create(_ photoData: Data, filename: String) async throws(ImageRepositoryError)

    func url(for filename: String) async throws(ImageRepositoryError) -> URL

}
