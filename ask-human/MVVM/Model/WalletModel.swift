//
//  WalletModel.swift
//  ask-human
//
//  Created by meet sharma on 26/02/24.
//

import Foundation

// MARK: - WalletModel
struct WalletModel: Codable {
    let status, message,url: String?
    let statusCode: Int?
    let data: WalletData?
}

// MARK: - WalletData
struct WalletData: Codable {
    let checkWallet: CheckWallet?
}

// MARK: - CheckWallet
struct CheckWallet: Codable {
    let id, userID, transactionID: String?
    let requestAmount,ammount: Int?
    let type: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case transactionID = "transactionId"
        case ammount, requestAmount, type, status, createdAt, updatedAt
        case v = "__v"
    }
}
