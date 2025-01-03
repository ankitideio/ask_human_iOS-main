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
    let hashtags: [Hashtagz]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, profileImage, mobile, about, gender, zodiac, age, smoke, drink, bodytype,videoVerify,reviews,hashtags
    }
}

// MARK: - Review
struct Review: Codable {
    let comment: String?
    let starCount: Double?
    let reviewerName: String?
    let reviewerProfileImage: String?
}
// MARK: - Hashtag
struct Hashtagz: Codable {
    let v: Int?
    let id: String?
    let createdAt: String?
    let createdBy: String?
    let isVerified: Int?
    let title: String?
    let updatedAt: String?
    let usedCount: Int?
    let userIds: [String]?

    enum CodingKeys: String, CodingKey {
        case v = "__v"
        case id = "_id"
        case createdAt
        case createdBy
        case isVerified
        case title
        case updatedAt
        case usedCount
        case userIds
    }
}
