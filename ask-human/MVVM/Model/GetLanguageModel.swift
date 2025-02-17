//
//  GetLanguageModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 09/01/25.
//

import Foundation
// MARK: - GetLanguageModel
struct GetLanguageModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetLanguageData?
}

// MARK: - DataClass
struct GetLanguageData: Codable {
    let languages: [Language]?
}

// MARK: - Language
struct Language: Codable {
    let id, name, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}
