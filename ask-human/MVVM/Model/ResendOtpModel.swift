//
//  ResendOtpModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/12/23.
//

import Foundation
// MARK: - ResendOtpModel
struct ResendOtpModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let otp: String?
}
