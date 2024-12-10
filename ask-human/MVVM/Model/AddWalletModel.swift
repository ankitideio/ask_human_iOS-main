//
//  AddWalletModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 10/07/24.
//

import Foundation
// MARK: - AddWalletModel
struct AddWalletModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetWalletData?
}

// MARK: - GetWalletData
struct GetWalletData: Codable {
    let url: String?
}
