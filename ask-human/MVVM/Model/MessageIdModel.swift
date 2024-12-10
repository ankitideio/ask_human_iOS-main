//
//  MessageIdModel.swift
//  ask-human
//
//  Created by meet sharma on 04/03/24.
//

import Foundation

// MARK: - MessageIdModel
struct MessageIdModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: MessageIdData?
}

// MARK: - DataClass
struct MessageIdData: Codable {
    let messageID: String?
}
