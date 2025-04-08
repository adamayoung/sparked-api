//
//  UserMapperTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 22/01/2025.
//

import Foundation
import Testing

@testable import IdentityInfrastructure

@Suite("UserMapper")
struct UserMapperTests {

    @Test("map from user model with ID")
    func mapFromUserModelWithID() throws {
        let id = try #require(UUID(uuidString: "12250C60-4AB7-4040-9BED-7F253981D58D"))
        let userModel = Self.buildUserModel(id: id)

        let user = try UserMapper.map(from: userModel)

        #expect(user.id == id)
    }

    @Test("map from user model throws error when ID is nil")
    func mapFromUserModelThrowsErrorWhenIDIsNil() throws {
        let userModel = Self.buildUserModel(id: nil)

        #expect(throws: (any Error).self) {
            _ = try UserMapper.map(from: userModel)
        }
    }

    @Test("map from user model with first name")
    func mapFromUserModelWithFirstName() throws {
        let firstName = "Dave"
        let userModel = Self.buildUserModel(firstName: firstName)

        let user = try UserMapper.map(from: userModel)

        #expect(user.firstName == firstName)
    }

    @Test("map from user model with family name")
    func mapFromUserModelWithLastName() throws {
        let familyName = "Smith"
        let userModel = Self.buildUserModel(familyName: familyName)

        let user = try UserMapper.map(from: userModel)

        #expect(user.familyName == familyName)
    }

    @Test("map from user model with email")
    func mapFromUserModelWithEmail() throws {
        let email = "example@email.com"
        let userModel = Self.buildUserModel(email: email)

        let user = try UserMapper.map(from: userModel)

        #expect(user.email == email)
    }

    @Test("map from user model when not verified")
    func mapFromUserModelWhenNotVerified() throws {
        let isVerified = false
        let userModel = Self.buildUserModel(isVerified: isVerified)

        let user = try UserMapper.map(from: userModel)

        #expect(user.isVerified == isVerified)
    }

    @Test("map from user model when verified")
    func mapFromUserModelWhenVerified() throws {
        let isVerified = true
        let userModel = Self.buildUserModel(isVerified: isVerified)

        let user = try UserMapper.map(from: userModel)

        #expect(user.isVerified == isVerified)
    }

    @Test("map from user model when active")
    func mapFromUserModelWhenActive() throws {
        let userModel = Self.buildUserModel(deletedAt: nil)

        let user = try UserMapper.map(from: userModel)

        #expect(user.isActive)
    }

    @Test("map from user model when not active")
    func mapFromUserModelWhenNotActive() throws {
        let deletedAt = Date(timeIntervalSince1970: 0)
        let userModel = Self.buildUserModel(deletedAt: deletedAt)

        let user = try UserMapper.map(from: userModel)

        #expect(!user.isActive)
    }

}

extension UserMapperTests {

    private static func buildUserModel(
        id: UUID? = UUID(uuidString: "12250C60-4AB7-4040-9BED-7F253981D58D"),
        firstName: String = "",
        familyName: String = "",
        email: String = "",
        password: String = "",
        isVerified: Bool = true,
        deletedAt: Date? = nil
    ) -> UserModel {
        let model = UserModel(
            id: id,
            firstName: firstName,
            familyName: familyName,
            email: email,
            password: password,
            isVerified: isVerified
        )
        model.deletedAt = deletedAt

        return model
    }

}
