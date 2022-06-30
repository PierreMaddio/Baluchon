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
        viewModel.loadData(to: "EUR", from: "USD", amount: "10") { str in

            // Then
            XCTAssertTrue(mockCurrencyService.convertExchangeIsCalled)
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertFalse(viewModel.loaderIsError)
        }
    }

    func test_loadData_failed() throws {
        // Given
        let mockCurrencyService = CurrencyServiceMockFailed()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "EUR", from: "USD", amount: "10") { str in

            // Then
            XCTAssertTrue(mockCurrencyService.convertExchangeIsCalled)
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertFalse(viewModel.loaderIsError)
        }
    }
}
