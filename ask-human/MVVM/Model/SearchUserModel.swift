//
//  SearchUserModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 08/12/23.
//

import Foundation
// MARK: - SearchUserModel
struct SearchUserModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: GetSearchData?
}

// MARK: - DataClass
struct GetSearchData: Codable {
    let users: [Userrr]?
}

// MARK: - User
struct Userrr: Codable {
    var isSelected: Bool = false
    let id, email: String?
    let profileImage: String?
    let mobile: Int?
    let about, name: String?
    let videoVerify:Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, profileImage, mobile, about, name,videoVerify
    }
}
