//
//  EarningModel.swift
//  ask-human
//
//  Created by meet sharma on 18/01/24.
//

import Foundation

// MARK: - Welcome
struct EarningModel: Codable {
    let status, message: String?
    let statusCode: Int?
    let data: EarningData?
}

// MARK: - EarningData
struct EarningData: Codable {
    let totalContact, totalEarnings, walletBalance, ammountperWeek: Int?
    let weekGraph: [WeekGraph]?
    let monthGraph: [MonthGraph]?
    let getMonthYear: [GetMonthYear]?
}

// MARK: - GetMonthYear
struct GetMonthYear: Codable {
    let year, totalAmount: Int?
}

// MARK: - MonthGraph
struct MonthGraph: Codable {
    let month, totalAmount: Int?
}

// MARK: - WeekGraph
struct WeekGraph: Codable {
    let week, totalAmount: Int?
}
