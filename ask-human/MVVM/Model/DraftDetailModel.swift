//
//  DraftDetailModel.swift
//  ask-human
//
//  Created by meet sharma on 24/12/23.
//

import Foundation

struct DraftDetailModel: Codable {
    let data: DraftDetailData?
    let message: String?
    let status: String?
    let statusCode: Int?
}

struct DraftDetailData: Codable {
    let notesDraftDetails: NotesDraftDetails?
}

struct NotesDraftDetails: Codable {
    let v: Int?
    let id: String?
    let createdAt: String?
    let isStatus: Int?
    let media: [String]?
    let note: String?
    let updatedAt: String?
    let userId: String?
    enum CodingKeys: String, CodingKey {
        case v = "__v"
        case id = "_id"
        case createdAt, isStatus, media, note, updatedAt, userId
    }
}
