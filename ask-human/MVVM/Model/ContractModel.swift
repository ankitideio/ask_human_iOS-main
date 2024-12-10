//
//  ContractModel.swift
//  ask-human
//
//  Created by meet sharma on 21/12/23.
//

import Foundation

// MARK: - ContractModel
struct ContractModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: ContractData?
}

// MARK: - ContractData
struct ContractData: Codable {
    let message: [Message]?
}

// MARK: - Message
struct Message: Codable {
    let id: String?
    let isDispute,isStatus:Int?
    let messageList: [MessageList]?
    let createdAt, updatedAt: String?
    let senders, recipients: Recipients?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case messageList, createdAt, updatedAt, senders, recipients,isDispute,isStatus
    }
}

// MARK: - MessageList
struct MessageList: Codable {
    let sender,recipient: Recipients?
//    let recipient: [Recipients]?
    let message: String?
    let isMyMsg: Bool?
    let createdAt, updatedAt: String?
}

// MARK: - Recipients
struct Recipients: Codable {
    let id: String?
    let name: String?
    let email: String?
    let mobile: Int?
    let profileImage: String?
    let videoVerify:Int?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, mobile, profileImage,videoVerify
    }
}
