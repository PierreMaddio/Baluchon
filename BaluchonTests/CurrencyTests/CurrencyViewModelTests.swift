//
//  CurrencyViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 19/06/2022.
//

import XCTest
@testable import Baluchon


class CurrencyViewModelTests: XCTestCase {

    func test_loadData_success() throws {
        // Given
        let mockCurrencyService = CurrencyServiceMockSuccess()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "USD", from: "EUR", amount: "10") { str in
            // Then
            XCTAssertFalse(viewModel.loaderIsVisible)
        }
    }
    
//    func testGetConvertionFrom10EuroToDollarShouldGetConvertion() throws {
//        // Given
//        let mockCurrencyService = CurrencyServiceMockSuccess()
//        let viewModel = CurrencyViewModel(service: mockCurrencyService)
//        // When
//        viewModel.loadData(to: "USD", from: "EUR", amount: "10") { string in
//            XCTAssertEqual(expression1: Equatable, expression2: Equatable)
//            // Error: Protocol 'Equatable' as a type cannot conform to the protocol itself
//        }
//    }

    func test_loadData_failed() throws {
        // Given
        let mockCurrencyService = CurrencyServiceMockFailed()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "EUR", from: "USD", amount: "10") { str in
            // Then
            XCTAssertFalse(viewModel.loaderIsVisible)
        }
    }
}
