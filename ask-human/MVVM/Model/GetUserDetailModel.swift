//
//  GetUserDetailModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 21/12/23.
//

import Foundation
// MARK: - GetUserDetailModel
struct GetUserDetailModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: UserData?
}

// MARK: - DataClass
struct UserData: Codable {
    let user: UserDeatil?

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct UserDeatil: Codable {
    let id, name: String?
    let profileImage: String?
    let mobile: Int?
    let about: String?
    let gender: Int?
    let zodiac: String?
    let age: Int?
    let smoke, drink, bodytype: String?
    let videoVerify:Int?
    let reviews: [Review]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, profileImage, mobile, about, gender, zodiac, age, smoke, drink, bodytype,videoVerify,reviews
    }
}

// MARK: - Review
struct Review: Codable {
    let comment: String?
    let starCount: Double?
    let reviewerName: String?
    let reviewerProfileImage: String?
}
