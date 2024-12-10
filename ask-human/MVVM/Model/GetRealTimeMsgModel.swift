//
//  GetRealTimeMsgModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 19/06/24.
//

import Foundation
// MARK: - GetRealTimeMsgModel
struct GetRealTimeMsgModel: Codable {
    let messages: [Messagez]?
    let unreadCount: Int?
}

// MARK: - Message
struct Messagez: Codable {
    let id, contractID,notesId: String?
    let sender, recipient: Recipient?
    var createdAt, updatedAt: String?
    var lastMessage: LastMessage?
    let favoriteBy: [String]?
    var unreadCount,isStatus: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case contractID = "contractId"
        case sender, recipient, createdAt, updatedAt, lastMessage, unreadCount,notesId,favoriteBy,isStatus
    }
}

// MARK: - LastMessage
struct LastMessage: Codable {
    var sender, recipient, message: String?
    let media: [String]?
    let socketID: String?
    let isMyMsg: Bool?
    var createdAt, updatedAt: String?
    let isRead: IsRead?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case sender, recipient, message, media
        case socketID = "socketId"
        case isMyMsg, createdAt, updatedAt, isRead
        case id = "_id"
    }
}

// MARK: - IsRead
struct IsRead: Codable {
    let sender, recipient: Bool?
}

// MARK: - Recipient
struct Recipient: Codable {
    let id, name: String?
    let profileImage: String?
    let about: String?
    let isApproved: Bool?
    let hoursPrice: Int?
    let isOnline: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, profileImage, about, isApproved, hoursPrice, isOnline
    }
}
