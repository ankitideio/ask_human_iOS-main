//
//  EthnicModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 09/01/25.
//

import Foundation
// MARK: - EthnicModel
struct EthnicModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetEthnicData?
}

// MARK: - DataClass
struct GetEthnicData: Codable {
    let ethnics: [Ethnic]?
}

// MARK: - Ethnic
struct Ethnic: Codable {
    let id, ethnic, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case ethnic, createdAt, updatedAt
        case v = "__v"
    }
}
