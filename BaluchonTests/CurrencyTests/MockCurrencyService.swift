//
//  CurrencyServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

import Foundation
@testable import Baluchon

// mock to simulate the service to do viewModelTests
class CurrencyServiceMockSuccess: CurrencyServiceProtocol {
    var convertExchangeIsCalled = false

    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?) -> (Void)) {
        convertExchangeIsCalled = true
        let currency = Currency(date: "",
                 historical: "",
                 info: .init(rate: 0.0,
                             timestamp: 0),
                 query: .init(amount: 0,
                              from: "",
                              to: ""),
                 result: 0.0,
                 success: true)
        completion(currency)
    }
}

class CurrencyServiceMockFailed: CurrencyServiceProtocol {
    var convertExchangeIsCalled = false

    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?) -> (Void)) {
        convertExchangeIsCalled = true
        completion(nil)
    }
}

