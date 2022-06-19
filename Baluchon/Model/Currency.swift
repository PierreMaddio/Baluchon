//
//  Currency.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

// MARK: - CurrencyExchange
struct Currency: Codable {
    let date: String?
    let historical: String?
    let info: Info?
    let query: Query?
    let result: Double?
    let success: Bool?
}

// MARK: - Info
struct Info: Codable {
    let rate: Double?
    let timestamp: Int?
}

// MARK: - Query
struct Query: Codable {
    let amount: Int?
    let from, to: String?
}
