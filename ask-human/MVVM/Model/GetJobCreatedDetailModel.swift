//
//  GetJobCreatedDetailModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 25/06/24.
//

import Foundation
// MARK: - GetJobCreatedDetailModel
struct GetJobCreatedDetailModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: [GetDetailData]?
}

// MARK: - Datum
struct GetDetailData: Codable {
    let rejectCount, referCount: Int?
    let notes: [Note]?
    let userID: [UserIDz]?

    enum CodingKeys: String, CodingKey {
        case rejectCount, referCount, notes
        case userID = "userId"
    }
}

// MARK: - Note
struct Note: Codable {
    let id, userID, note: String?
    let media: [String]?
    let isStatus: Int?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case note, media, isStatus, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - UserID
struct UserIDz: Codable {
    let id, role, name, email: String?
    let profileImage: String?
    let mobile: Int?
    let password, about: String?
    let gender: Int?
    let zodiac: String?
    let age: Int?
    let smoke, drink, workout, bodytype: String?
    let deviceID: String?
//    let fcmToken: String?
    let isApproved, isEmailVerify, isOnline, isMobileVerify: Bool?
    let profileComplete, otp, hoursPrice: Int?
    let loginType: String?
    let socialID: String?
    let stripeCustomerID: String?
    let defaultPaymentMethod, socialType, video: String?
    let videoVerify: Int?
    let isBlocked, isDeleted: Bool?
    let createdAt, updatedAt: String?
    let v: Int?
    let token, ethnicity: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case role, name, email, profileImage, mobile, password, about, gender, zodiac, age, smoke, drink, workout, bodytype
        case deviceID = "deviceId"
        case isApproved, isEmailVerify, isOnline, isMobileVerify, profileComplete, otp, hoursPrice, loginType
        case socialID = "socialId"
        case stripeCustomerID = "stripeCustomerId"
        case defaultPaymentMethod = "default_payment_method"
        case socialType, video, videoVerify, isBlocked, isDeleted, createdAt, updatedAt
        case v = "__v"
        case token, ethnicity
    }
}
