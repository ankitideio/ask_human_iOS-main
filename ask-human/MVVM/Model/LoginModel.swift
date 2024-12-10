//
//  LoginModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//

import Foundation
// MARK: - LoginModel
struct LoginModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: LoginData?
}

// MARK: - DataClass
struct LoginData: Codable {
    let mobile:Int?
    let token:String?
    let mobileOtp: String?
    let user: User?
}

// MARK: - User
struct User: Codable {
    let id, role: String?
    let name: String?
    let email: String?
    let profileImage, countryCode,ethnicity,zodiac,workout,smoke,drink,bodytype: String?
    let mobile,profileComplete,gender: Int?
    let password: String?
    let about, deviceID: String?
    let fcmToken: [String]?
    let isApproved, isEmailVerify, isMobileVerify: Bool?
    let socialID, socialType: String?
    let isBlocked, isDeleted: Bool?
    let createdAt, updatedAt: String?
    let v, otp,age,hoursPrice: Int?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case role, name, email, profileImage, countryCode, mobile, password, about,profileComplete,age,gender,ethnicity,zodiac,workout,smoke,drink,bodytype
        case deviceID = "deviceId"
        case fcmToken, isApproved, isEmailVerify, isMobileVerify
        case socialID = "socialId"
        case socialType, isBlocked, isDeleted, createdAt, updatedAt
        case v = "__v"
        case otp, token,hoursPrice
    }
}
