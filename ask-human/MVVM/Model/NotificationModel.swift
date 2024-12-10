//
//  NotificationModel.swift
//  ask-human
//
//  Created by meet sharma on 15/12/23.
//

import Foundation



// MARK: - NotificationModel
struct NotificationModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: NotificationData?
}

// MARK: - DataClass
struct NotificationData: Codable {
    let notifications: [Notificationss]?
    let unreadCount: Int
}

// MARK: - Notification
struct Notificationss: Codable {
    let id: String?
    let userID: UserID?
    let receiverID: String?
    let notesID: NotesID?
    let messageID, message, status: String?
    let title: String?
    let username:String?
    let isRead, allClear: Bool?
    let createdAt, updatedAt,contractId: String?
    let v,isAcceptOrReject: Int?
    let timeCategory: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case receiverID = "receiverId"
        case notesID = "notesId"
        case messageID = "messageId"
        case message, status, title, isRead, allClear, createdAt, updatedAt,contractId
        case v = "__v"
        case timeCategory,isAcceptOrReject,username
    }
}

// MARK: - NotesID
struct NotesID: Codable {
    let id: String?
    let userID: String?
    let note: String?
    let media: [String]?
    let isStatus: Int?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case note, media, isStatus, createdAt, updatedAt
        case v = "__v"
    }
}






// MARK: - UserID
struct UserID: Codable {
    let id: String?
    let name: String?
    let email: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, profileImage
    }
}


