//
//  PolicyAndHelpModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 15/01/25.
//

import Foundation
// MARK: - PolicyAndHelpModel
struct PolicyAndHelpModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetPolicydata?
}

// MARK: - DataClass
struct GetPolicydata: Codable {
    let content: [ContentPolicies]?
}

// MARK: - Content
struct ContentPolicies: Codable {
    let id, type, title, description: String?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type, title, description, createdAt, updatedAt
        case v = "__v"
    }
}
