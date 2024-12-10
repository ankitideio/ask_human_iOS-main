//
//  GetDraftNoteModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/12/23.
//

import Foundation
// MARK: - GetDraftNoteModel
struct GetDraftNoteModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: DraftData?
}

// MARK: - DataClass
struct DraftData: Codable {
    let draftList: [DraftList]?
}

// MARK: - DraftList
struct DraftList: Codable {
    let id, userID, note: String?
    let media: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case note, media
    }
}
