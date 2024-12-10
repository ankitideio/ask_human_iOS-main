//
//  FileUploadModel.swift
//  ask-human
//
//  Created by meet sharma on 05/03/24.
//

import Foundation

// MARK: - FileUploadModel
struct FileUploadModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: FileUploadData?
}

// MARK: - FileUploadData
struct FileUploadData: Codable {
    let imageUrl: String?
}
