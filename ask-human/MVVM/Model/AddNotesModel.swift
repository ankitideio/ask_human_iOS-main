//
//  AddNotesModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 14/12/23.
//

import Foundation
// MARK: - AddNotesModel
struct AddNotesModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: NotesData?
}

// MARK: - DataClass
struct NotesData: Codable {
    let createNotes: CreateNotes?
}

// MARK: - CreateNotes
struct CreateNotes: Codable {
    let userID, note: String?
    let media: [String]?
    let isStatus: Int?
    let id, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case note, media, isStatus
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
