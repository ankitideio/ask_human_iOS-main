//
//  VerifyHashtagModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 23/12/24.
//

import Foundation

struct VerifyHashtagModel: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: VerificationHashtagData?
}

struct VerificationHashtagData: Codable {
    let id: String?
    let title: String?
    let userIds: [String]?
    let isVerified: Int?
    let usedCount: Int?
    let createdBy: String?
    let createdAt: String?
    let updatedAt: String?
    let version: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case userIds
        case isVerified
        case usedCount
        case createdBy
        case createdAt
        case updatedAt
        case version = "__v"
    }
}

