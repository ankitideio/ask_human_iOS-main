//
//  AppliedRequestsModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 25/06/24.
//

import Foundation
// MARK: - AppliedRequestsModel
struct AppliedRequestsModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: [GetRequestsData]?
}

// MARK: - GetRequestsData
struct GetRequestsData: Codable {
    let id: String?
    let referBy: ReferBy?
    let appliedBy, message: String?
    let status: Int?
    let notes: Notes?
    let userID: ReferBy?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case referBy, appliedBy, message, status, notes
        case userID = "userId"
    }
}

// MARK: - Notes
struct Notes: Codable {
    let id: String?
    let userID: String?
    let note: String?
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


// MARK: - ReferBy
struct ReferBy: Codable {
    let id: String?
    let role: String?
    let name: String?
    let email: String?
    let profileImage: String?
    let mobile: Int?
    let password: String?
    let about: String?
    let gender: Int?
    let zodiac: String?
    let age: Int?
    let smoke, drink: String?
    let workout: String?
    let bodytype: String?
    let deviceID: String?
//    let fcmToken: Int?
    let isApproved, isEmailVerify, isOnline, isMobileVerify: Bool?
    let profileComplete, otp, hoursPrice: Int?
    let loginType: String?
    let socialID: String?
    let stripeCustomerID: String?
    let defaultPaymentMethod, socialType, video: String?
    let videoVerify: Int?
    let isBlocked, isDeleted: Bool?
    let createdAt: String?
    let updatedAt: String?
    let v: Int?
    let token: String?
    let ethnicity: String?

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

//// MARK: - AppliedRequestsModel
//struct AppliedRequestsModel: Codable {
//    let status, message: String?
//    let statusCode: Int?
//    let data: [GetRequestsData]?
//}
//
//// MARK: - Datum
//struct GetRequestsData: Codable {
//    let id: String?
//    let referBy, appliedBy: By?
//    let message: String?
//    let status: Int?
//    let notes: Notes?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case referBy, appliedBy, message, status, notes
//    }
//}
//
//// MARK: - By
//struct By: Codable {
//    let id, role, name, email: String?
//    let profileImage: String?
//    let mobile: Int?
//    let password, about: String?
//    let gender: Int?
//    let zodiac: String?
//    let age: Int?
//    let smoke, drink, workout, bodytype: String?
//    let deviceID: String?
//    let fcmToken: String?
//    let isApproved, isEmailVerify, isOnline, isMobileVerify: Bool?
//    let profileComplete, otp, hoursPrice: Int?
//    let loginType: String?
//    let socialID: String?
//    let stripeCustomerID: String?
//    let defaultPaymentMethod, socialType, video: String?
//    let videoVerify: Int?
//    let isBlocked, isDeleted: Bool?
//    let createdAt, updatedAt: String?
//    let v: Int?
//    let token, ethnicity: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case role, name, email, profileImage, mobile, password, about, gender, zodiac, age, smoke, drink, workout, bodytype
//        case deviceID = "deviceId"
//        case fcmToken, isApproved, isEmailVerify, isOnline, isMobileVerify, profileComplete, otp, hoursPrice, loginType
//        case socialID = "socialId"
//        case stripeCustomerID = "stripeCustomerId"
//        case defaultPaymentMethod = "default_payment_method"
//        case socialType, video, videoVerify, isBlocked, isDeleted, createdAt, updatedAt
//        case v = "__v"
//        case token, ethnicity
//    }
//}
//
//// MARK: - Notes
//struct Notes: Codable {
//    let id, userID, note: String?
//    let media: [String]?
//    let isStatus: Int?
//    let createdAt, updatedAt: String?
//    let v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case userID = "userId"
//        case note, media, isStatus, createdAt, updatedAt
//        case v = "__v"
//    }
//}
