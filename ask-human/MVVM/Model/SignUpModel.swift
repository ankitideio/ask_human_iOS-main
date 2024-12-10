//
//  SignUpModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//

import Foundation

// MARK: - SignUpModel
struct SignUpModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: SignUpData?
}

// MARK: - DataClass
struct SignUpData: Codable {
    let mobileOtp,token: String?
    let user: UserDetail?
}

// MARK: - User
struct UserDetail: Codable {
    let role: String?
    let name: String?
    let email: String?
    let profileImage, countryCode: String?
    let mobile: Int?
    let password: String?
    let about: String?
    let gender: Int?
    let zodiac, age, smoke, drink: String?
    let workout, bodytype, deviceID: String?
    let fcmToken: [String]?
    let isApproved, isEmailVerify, isMobileVerify: Bool?
    let socialID, socialType: String?
    let isBlocked, isDeleted: Bool?
    let id, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case role, name, email, profileImage, countryCode, mobile, password, about, gender, zodiac, age, smoke, drink, workout, bodytype
        case deviceID = "deviceId"
        case fcmToken, isApproved, isEmailVerify, isMobileVerify
        case socialID = "socialId"
        case socialType, isBlocked, isDeleted
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}

