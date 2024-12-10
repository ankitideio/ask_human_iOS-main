//
//  ChatModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 23/01/24.
//

import Foundation

struct ChatModel: Codable {
    let id: String?
    let messageList: [MessageListChat]?
    let isStatus, isDispute, endContract,continueChat: Int?
    let senders, recipients,referredBY: RecipientsChat?
    let startTime,endTime:String?
    let isRefered: Bool?
    let isApplied,isReferedRequest: Bool?
    let isReferedStatus:Int?
    let proposedMessage: String?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case messageList, isStatus, isDispute, endContract, senders,proposedMessage,isReferedRequest, recipients,continueChat,startTime,endTime,referredBY,isApplied,isRefered,isReferedStatus
    }
}

// MARK: - MessageList
struct MessageListChat: Codable {
    let sender: String?
    let recipient: RecipientsChat?
    let message: String?
    let media: [String]?
    let createdAt: String?
    let senderdetails: RecipientsChat?
}

// MARK: - Recipients
struct RecipientsChat: Codable {
    let id: String?
    let name: String?
    let profileImage: String?
    let hoursPrice:Int?
    let about:String?
    let isApproved:Bool?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, profileImage,hoursPrice,about,isApproved
    }
}
