//
//  MyDisputeModel.swift
//  ask-human
//
//  Created by meet sharma on 24/12/23.
//

import Foundation


struct MyDisputeModel: Codable {
    let statusCode: Int?
    let data: MyDisputeData?
    let status: String?
    let message: String?
}

struct MyDisputeData: Codable {
    let disputeList: [Dispute]?
}

struct Dispute: Codable {
    let id: String?
    let comment: String?
    let createdAt: String?
    let isStatus: Int?
    let message: DisputeMessage?
    let reasons: DisputeReason?
    let userId: String?
    let users: DisputeUser?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case comment, createdAt, isStatus, message, reasons, userId, users
    }
}

struct DisputeMessage: Codable {
    let id,contractId: String?
    let isDispute: Int?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isDispute,contractId
    }
}

struct DisputeReason: Codable {
    let id: String?
    let reason: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case reason
    }
}

struct DisputeUser: Codable {
    let id: String?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
