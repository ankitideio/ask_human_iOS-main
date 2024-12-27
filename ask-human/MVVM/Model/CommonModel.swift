//
//  CommonModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//

import Foundation

// MARK: - CommonModel
struct CommonModel: Codable {
    let status, message,url: String?
    let statusCode: Int?
    let data: GetDataa?
}

// MARK: - DataClass
struct GetDataa: Codable {
    let gender: Int?
}
