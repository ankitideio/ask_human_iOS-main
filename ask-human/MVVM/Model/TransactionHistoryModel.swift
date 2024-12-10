//
//  TransactionHistoryModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 16/01/24.
//

import Foundation
// MARK: - TransactionHistoryModel
struct TransactionHistoryModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data:[TransactionList]?
}

//// MARK: - DataClass
//struct GetHistoryData: Codable {
//    let transactionList: [TransactionList]?
//}

// MARK: - TransactionList
struct TransactionList: Codable {
    let id, pendingAmmount, type: String?
    let createdAt: String?
    let ammount:Int?
    let transactionHistory: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case ammount, pendingAmmount, type, createdAt, transactionHistory
    }
}
