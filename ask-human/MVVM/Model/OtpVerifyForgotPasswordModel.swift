//
//  OtpVerifyForgotPasswordModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 12/12/23.
//

import Foundation
// MARK: - OtpVerifyForgotPasswordModel
struct OtpVerifyForgotPasswordModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetOtpVerifyData?
}

// MARK: - DataClass
struct GetOtpVerifyData: Codable {
    let userDetails: UserDetailss?
}

// MARK: - UserDetails
struct UserDetailss: Codable {
    let id, email: String?
    let mobile: Int?
    let token, name: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, mobile, token, name
    }
}
