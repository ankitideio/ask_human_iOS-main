//
//  ProfileDetailModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 08/12/23.
//

import Foundation
// MARK: - ProfileDetailModel
struct ProfileDetailModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: ProfileDetailData?
}

// MARK: - DataClass
struct ProfileDetailData: Codable {
    let user: Userr?
}

// MARK: - User
struct Userr: Codable {
    let id, name, email: String?
    let profileImage: String?
    let mobile: Int?
    let about: String?
    let age,videoVerify: Int?
    let bodytype, drink, ethnicity: String?
    let gender,hoursPrice: Int?
    let smoke, workout, zodiac,token: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, profileImage, mobile, about, age, bodytype, drink, ethnicity, gender, smoke, workout, zodiac,videoVerify,hoursPrice,token
    }
}
