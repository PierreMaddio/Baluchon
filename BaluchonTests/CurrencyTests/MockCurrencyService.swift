//
//  CurrencyServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

@testable import Baluchon

//In the unit tests we can't mock the network service
//So we use the protocols that are used to mock the network services

// mock to simulate the service to do viewModelTests
class CurrencyServiceMockSuccess: CurrencyServiceProtocol {
    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?, ErrorBaluchon?) -> (Void)) {
        let currency = Currency(date: "2022-07-06",
                 historical: "",
                 info: .init(rate: 1.017589,
                             timestamp: 1657113036),
                 query: .init(amount: 20,
                              from: "EUR",
                              to: "USD"),
                 result: 20.35178,
                 success: true)
        completion(currency, nil)
    }
}

class CurrencyServiceMockFailed: CurrencyServiceProtocol {
    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?, ErrorBaluchon?) -> (Void)) {
        completion(nil, .errorNetWork)
    }
}

