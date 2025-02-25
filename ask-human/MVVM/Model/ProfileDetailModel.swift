//
//  ProfileDetailModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 08/12/23.
//
// MARK: - ProfileDetailModel
struct ProfileDetailModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: ProfileDetailData?
}

// MARK: - DataClass
struct ProfileDetailData: Codable {
    let user: Userr?
    let completionPercentage:Int?
}

// MARK: - User
struct Userr: Codable {
    let id, name, email,nationality,document: String?
    let profileImage: String?
    let mobile,identity: Int?
    let countryCode, about: String?
    let gender: Int?
    let ethnicity, zodiac: String?
    let age: Int?
    let smoke, drink, workout, bodytype: String?
    let hoursPrice, videoVerify: Int?
    let hashtags: [Hashtag]?
    let languages: [Languagez]?
    let dob: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, profileImage, mobile, countryCode, about, gender, ethnicity, zodiac, age, smoke, drink, workout, bodytype, hoursPrice, videoVerify, hashtags, dob,nationality,document,identity,languages
    }
}

// MARK: - Hashtag
struct Hashtag: Codable {
    let id, title: String?
    let userIDS: [String]?
    let isVerified, usedCount: Int?
    let createdBy, createdAt, updatedAt: String?
   // let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case userIDS = "userIds"
        case isVerified, usedCount, createdBy, createdAt, updatedAt
       // case v = "__v"
    }
}

// MARK: - Language
struct Languagez: Codable {
    let version: Int?
    let id: String?
    let createdAt: String?
    let name: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case version = "__v"
        case id = "_id"
        case createdAt, name, updatedAt
    }
}
