//
//  SearchHashtagModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 23/12/24.
//

import Foundation
// MARK: - SearchHashtagModel
struct SearchHashtagModel: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: [GetSearchHashtagData]?
    let metadata: Metadataa?
}

// MARK: - Datum
struct GetSearchHashtagData: Codable {
    let usedCount: Int?
    let id, title: String?
    let isVerified: Int?

    enum CodingKeys: String, CodingKey {
        case usedCount
        case id = "_id"
        case title, isVerified
    }
}

// MARK: - Metadata
struct Metadataa: Codable {
    let totalResults, totalPages, currentPage: Int?
}
