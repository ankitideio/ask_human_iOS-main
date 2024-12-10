//
//  AddMobileAndEmailModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 20/12/23.
//

import Foundation
// MARK: - AddMobileAndEmailModel
struct AddMobileAndEmailModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetOtpData?
}

// MARK: - DataClass
struct GetOtpData: Codable {
    let otp: String?
}
