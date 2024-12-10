//
//  ForgotPasswordModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 12/12/23.
//

import Foundation
// MARK: - ForgotPasswordModel
struct ForgotPasswordModel: Codable {
    let status, message: String
    let statusCode: Int?
    let data: GetForgotData?
}

// MARK: - DataClass
struct GetForgotData: Codable {
    let token, otp: String?
}
