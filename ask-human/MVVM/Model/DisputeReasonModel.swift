//
//  DisputeReasonModel.swift
//  ask-human
//
//  Created by meet sharma on 24/12/23.
//

import Foundation

struct DisputeReasonModel: Codable {
    let message: String?
    let statusCode: Int?
    let status: String?
    let data: DisputeReasonData?
}

struct DisputeReasonData: Codable {
    let reasonList: [Reason]
}

struct Reason: Codable {
    let id: String?
    let createdAt: String?
    let isDefault: Bool?
//    let isDeleted: Int?
//    let isStatus: Int?
    let reason: String?
    let updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt, isDefault, reason, updatedAt
    }
}
