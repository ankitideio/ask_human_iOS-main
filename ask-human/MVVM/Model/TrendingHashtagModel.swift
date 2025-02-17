//
//  TrendingHashtagModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 09/01/25.
//

import Foundation
// MARK: - TrendingHashtagModel
struct TrendingHashtagModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetHashtagData?
}

// MARK: - DataClass
struct GetHashtagData: Codable {
    let hashtags: [Hashtaggs]?
}

// MARK: - Hashtag
struct Hashtaggs: Codable {
    let id, title: String?
    let isVerified: Int?
    let createdBy: String?
    let usedCount: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, isVerified, createdBy, usedCount
    }
}
