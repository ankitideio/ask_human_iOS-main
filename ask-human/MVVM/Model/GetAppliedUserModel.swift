//
//  GetAppliedUserModel.swift
//  ask-human
//
//  Created by meet sharma on 27/06/24.
//

import Foundation
// MARK: - GetAppliedUserModel
struct GetAppliedUserModel: Codable {
    var status, message: String?
    var statusCode: Int?
    var data: GetRequests?
}

// MARK: - GetRequests
struct GetRequests: Codable {
    var appliedUsers: [AppliedUser]?

    enum CodingKeys: String, CodingKey {
        case appliedUsers = "AppliedUsers"
    }
}

// MARK: - AppliedUser
struct AppliedUser: Codable {
    var id: String?
    var referBy, appliedBy: Byy?
    var message: String?
    var status: Int?
    var isDeleted: Bool?
    var notes: Notesz?
    var notesID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case referBy, appliedBy, message, status, isDeleted, notes
        case notesID = "notesId"
    }
}

// MARK: - By
struct Byy: Codable {
    var id, role, name, email: String?
    var profileImage: String?
    var mobile: Int?
    var password, about: String?
    var gender: Int?
    var zodiac: String?
    var age: Int?
    var smoke, drink, workout, bodytype: String?
    var deviceID: String?
    var fcmToken: String?
    var isApproved, isEmailVerify, isOnline, isMobileVerify: Bool?
    var profileComplete, otp, hoursPrice: Int?
    var loginType: String?
    var socialID: String?
    var stripeCustomerID: String?
    var defaultPaymentMethod, socialType, video: String?
    var videoVerify: Int?
    var isBlocked, isDeleted: Bool?
    var createdAt, updatedAt: String?
    var v: Int?
    var token, ethnicity: String?
    let reviews: [Reviewz]?
    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case role, name, email, profileImage, mobile, password, about, gender, zodiac, age, smoke, drink, workout, bodytype
        case deviceID = "deviceId"
        case fcmToken, isApproved, isEmailVerify, isOnline, isMobileVerify, profileComplete, otp, hoursPrice, loginType
        case socialID = "socialId"
        case stripeCustomerID = "stripeCustomerId"
        case defaultPaymentMethod = "default_payment_method"
        case socialType, video, videoVerify, isBlocked, isDeleted, createdAt, updatedAt
        case v = "__v"
        case token, ethnicity,reviews
    }
}
// MARK: - Review
struct Reviewz: Codable {
    let v: Int?
    let id, comment, createdAt, messageId: String?
    let notesId, receiverId: String?
    let starCount: Double?
    let updatedAt, userId: String?

    enum CodingKeys: String, CodingKey {
        case v = "__v"
        case id = "_id"
        case comment, createdAt, messageId, notesId, receiverId, starCount, updatedAt, userId
    }
}

// MARK: - Notes
struct Notesz: Codable {
    var id, userID, note: String?
    var media: [String]?
    var isStatus: Int?
    var createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case note, media, isStatus, createdAt, updatedAt
        case v = "__v"
    }
}
