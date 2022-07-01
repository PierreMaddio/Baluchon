//
//  CurrencyServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

import Foundation
@testable import Baluchon

//In the unit tests we can't mock the network service
//So we use the protocols that are used to mock the network services

// mock to simulate the service to do viewModelTests
class CurrencyServiceMockSuccess: CurrencyServiceProtocol {
    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?) -> (Void)) {
        let currency = Currency(date: "2022-07-01",
                 historical: "",
                 info: .init(rate: 1.040658,
                             timestamp: 1656680883),
                 query: .init(amount: 10,
                              from: "EUR",
                              to: "USD"),
                 result: 10.40658,
                 success: true)
        completion(currency)
    }
}

class CurrencyServiceMockFailed: CurrencyServiceProtocol {
    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?) -> (Void)) {
        completion(nil)
    }
}

