//
//  EducationLevelDefaultCacheDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class EducationLevelCacheDefaultDataSource: EducationLevelCacheDataSource {

    private enum CacheKey {
        private static let prefix =
            "ReferenceDataInfrastructure.EducationLevelCacheDefaultDataSource"

        static let educationLevels = "\(prefix).educationLevels"
    }

    private let cacheProvider: any CacheProvider

    init(cacheProvider: some CacheProvider) {
        self.cacheProvider = cacheProvider
    }

    func fetchAll() async throws(EducationLevelRepositoryError) -> [EducationLevel]? {
        let dictionary = try await educationLevels()

        return dictionary?.values.map(\.self)
    }

    func setEducationLevels(
        _ educationLevels: [EducationLevel]
    ) async throws(EducationLevelRepositoryError) {
        let dictionary = educationLevels.reduce(into: [:]) { dictionary, country in
            dictionary[country.id] = country
        }

        try await setEducationLevels(dictionary)
    }

    func fetch(
        byID id: EducationLevel.ID
    ) async throws(EducationLevelRepositoryError) -> EducationLevel? {
        let dictionary: [EducationLevel.ID: EducationLevel]?
        do {
            dictionary = try await self.educationLevels()
        } catch let error {
            throw .unknown(error)
        }

        return dictionary?[id]
    }

    func setEducationLevel(
        _ educationLevel: EducationLevel
    ) async throws(EducationLevelRepositoryError) {
        let dictionary: [EducationLevel.ID: EducationLevel]?
        do {
            dictionary = try await self.educationLevels()
        } catch let error {
            throw .unknown(error)
        }

        var newDictionary = dictionary ?? [:]
        newDictionary[educationLevel.id] = educationLevel

        do {
            try await setEducationLevels(newDictionary)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension EducationLevelCacheDefaultDataSource {

    private func educationLevels() async throws(EducationLevelRepositoryError) -> [EducationLevel
        .ID: EducationLevel]?
    {
        do {
            return try await cacheProvider.get(forKey: CacheKey.educationLevels)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func setEducationLevels(
        _ educationLevels: [EducationLevel.ID: EducationLevel]
    ) async throws(EducationLevelRepositoryError) {
        do {
            try await cacheProvider.set(educationLevels, forKey: CacheKey.educationLevels)
        } catch let error {
            throw .unknown(error)
        }
    }

}
