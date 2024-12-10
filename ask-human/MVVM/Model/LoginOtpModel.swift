//
//  LoginOtpModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 06/12/23.
//

import Foundation
// MARK: - LoginOtpModel
struct LoginOtpModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: OtpData?
}

// MARK: - DataClass
struct OtpData: Codable {
    let mobileOtp: String?
}
