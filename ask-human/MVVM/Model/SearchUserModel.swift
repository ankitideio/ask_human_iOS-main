//
//  SearchUserModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 08/12/23.
//

import Foundation
// MARK: - Welcome
struct SearchUserModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetSearchData?
}

// MARK: - DataClass
struct GetSearchData: Codable {
    let totalPages,totalCount: Int?
    let users: [Userrr]?
}

// MARK: - User
struct Userrr: Codable {
    let hashtags: [Hashtagg]?
    let id, name, email: String?
    let profileImage,badge: String?
    let mobile: Int?
    let about: String?
    let gender, age, videoVerify,hoursPrice,chatCount: Int?
    let isOnline:Bool?
    let rating:Double?

    enum CodingKeys: String, CodingKey {
        case hashtags
        case id = "_id"
        case name, email, profileImage, mobile, about, gender, age, videoVerify,badge,isOnline,rating,hoursPrice,chatCount
    }
}

// MARK: - Hashtag
struct Hashtagg: Codable {
    let id, title: String?
    let usedCount,isVerified: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, usedCount,isVerified
    }
}
