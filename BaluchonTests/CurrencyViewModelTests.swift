//
//  CurrencyViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 19/06/2022.
//

import XCTest

import XCTest
@testable import Baluchon


class CurrencyViewModelTests: XCTestCase {

    func testLoadData_success() throws {
        // Given
        let mockCurrencyService = CurrencyServiceMockSuccess()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "EUR", from: "USD", amount: "10") { str in

            // Then
            XCTAssertTrue(mockCurrencyService.convertExchangeIsCalled)
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertFalse(viewModel.loaderIsError)
        }
    }

    func testLoadData_failed() throws {
        // Given
        let mockCurrencyService = CurrencyServiceMockFailed()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "EUR", from: "USD", amount: "10") { str in

            // Then
            XCTAssertTrue(mockCurrencyService.convertExchangeIsCalled)
            XCTAssertTrue(viewModel.loaderIsVisible)
            XCTAssertTrue(viewModel.loaderIsError)
        }
    }
}


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
