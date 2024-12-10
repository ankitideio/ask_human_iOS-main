//
//  PhoneVerificatioModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/12/23.
//

import Foundation
// MARK: - PhoneVerificatioModel
struct PhoneVerificatioModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: VerificationData?
}

// MARK: - DataClass
struct VerificationData: Codable {
    let userDetails: UserDetails?
    let token: String?
}

// MARK: - UserDetails
struct UserDetails: Codable {
    let id: String?
    let name: String?
    let email: String?
    let mobile: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, mobile
    }
}
