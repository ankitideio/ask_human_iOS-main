//
//  DocumentModel.swift
//  ask-human
//
//  Created by IDEIO SOFT on 26/12/24.
//

import Foundation

struct DocumentModel: Codable {
    let status: String?
    let message: String?
    let data: GetDocumentDataa?
}

// Define the Codable structure for the 'data' object
struct GetDocumentDataa: Codable {
    let gender: Int?
}
