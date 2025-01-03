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
// MARK: - User
struct User: Codable {
    let id, role: String?
    let name: String?
    let email: String?
    let profileImage, countryCode, ethnicity, zodiac, workout, smoke, drink, bodytype: String?
    let mobile, profileComplete, gender: Int?
    let password: String?
    let about, deviceID: String?
    let fcmToken: [String]?
    let isApproved, isEmailVerify, isMobileVerify: Bool?
    let socialID, socialType: String?
    let isBlocked, isDeleted: Bool?
    let createdAt, updatedAt, dob: String?
    let v, otp, age, hoursPrice: Int?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case role, name, email, profileImage, countryCode, mobile, password, about, profileComplete, age, gender, ethnicity, zodiac, workout, smoke, drink, bodytype, dob
        case deviceID = "deviceId"
        case fcmToken, isApproved, isEmailVerify, isMobileVerify
        case socialID = "socialId"
        case socialType, isBlocked, isDeleted, createdAt, updatedAt
        case v = "__v"
        case otp, token, hoursPrice
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        role = try container.decodeIfPresent(String.self, forKey: .role)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
        countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
        ethnicity = try container.decodeIfPresent(String.self, forKey: .ethnicity)
        zodiac = try container.decodeIfPresent(String.self, forKey: .zodiac)
        workout = try container.decodeIfPresent(String.self, forKey: .workout)
        smoke = try container.decodeIfPresent(String.self, forKey: .smoke)
        drink = try container.decodeIfPresent(String.self, forKey: .drink)
        bodytype = try container.decodeIfPresent(String.self, forKey: .bodytype)
        mobile = try container.decodeIfPresent(Int.self, forKey: .mobile)
        profileComplete = try container.decodeIfPresent(Int.self, forKey: .profileComplete)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        about = try container.decodeIfPresent(String.self, forKey: .about)
        deviceID = try container.decodeIfPresent(String.self, forKey: .deviceID)
        
        // Decode fcmToken as either a String or an array of Strings
        if let tokenArray = try? container.decode([String].self, forKey: .fcmToken) {
            fcmToken = tokenArray
        } else if let tokenString = try? container.decode(String.self, forKey: .fcmToken) {
            fcmToken = [tokenString]
        } else {
            fcmToken = nil
        }
        
        isApproved = try container.decodeIfPresent(Bool.self, forKey: .isApproved)
        isEmailVerify = try container.decodeIfPresent(Bool.self, forKey: .isEmailVerify)
        isMobileVerify = try container.decodeIfPresent(Bool.self, forKey: .isMobileVerify)
        socialID = try container.decodeIfPresent(String.self, forKey: .socialID)
        socialType = try container.decodeIfPresent(String.self, forKey: .socialType)
        isBlocked = try container.decodeIfPresent(Bool.self, forKey: .isBlocked)
        isDeleted = try container.decodeIfPresent(Bool.self, forKey: .isDeleted)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        dob = try container.decodeIfPresent(String.self, forKey: .dob)
        v = try container.decodeIfPresent(Int.self, forKey: .v)
        otp = try container.decodeIfPresent(Int.self, forKey: .otp)
        age = try container.decodeIfPresent(Int.self, forKey: .age)
        hoursPrice = try container.decodeIfPresent(Int.self, forKey: .hoursPrice)
        token = try container.decodeIfPresent(String.self, forKey: .token)
    }
}
