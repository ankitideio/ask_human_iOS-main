//
//  MessageDetailModel.swift
//  ask-human
//
//  Created by meet sharma on 27/12/23.
//

import Foundation

// MARK: - MessageDetailModel
struct MessageDetailModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: MessageDetailData?
}

// MARK: - DataClass
struct MessageDetailData: Codable {
    let messageDetail: MessageDetails?
}

// MARK: - MessageDetail
struct MessageDetails: Codable {
    let id: String?
    let messageList: [MessageLists]?
    let isDispute: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case messageList, isDispute, createdAt, updatedAt
    }
}

// MARK: - MessageList
struct MessageLists: Codable {
    let sender: Sender?
    let recipient: [Sender]?
    let message: String?
    let media: [String]?
    let isMyMsg: Bool?
    let createdAt, updatedAt: String?
}

// MARK: - Sender
struct Sender: Codable {
    let id, name, email: String?
    let mobile: Int?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, mobile, profileImage
    }
}
