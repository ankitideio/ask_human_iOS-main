//
//  ProfileModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 07/12/23.
//

import Foundation
// MARK: - ProfileModel
struct ProfileModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetProfileData?
}

// MARK: - DataClass
struct GetProfileData: Codable {
    let user: UserProfile?
}

// MARK: - User
struct UserProfile: Codable {
    let id: String?
    let name: String?
    let email: String?
    let profileImage: String?
    let mobile: Int?
    let about: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, profileImage, mobile, about
    }
}
