//
//  CurrencyViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 19/06/2022.
//

import XCTest
@testable import Baluchon


class CurrencyViewModelTests: XCTestCase {
    
    func testGetConvertionFrom20EuroToDollarShouldGetConvertion() {
        // Given
        let mockCurrencyService = CurrencyServiceMockSuccess()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "USD", from: "EUR", amount: "20") { str in
            // Then
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertEqual(viewModel.result, String(20.35178))
        }
    }
    
    func testGetConvertionFrom20EuroToDollarShouldFailed() {
        // Given
        let mockCurrencyService = CurrencyServiceMockFailed()
        let viewModel = CurrencyViewModel(service: mockCurrencyService)
        // When
        viewModel.loadData(to: "USD", from: "EUR", amount: "20") { str in
            // Then
            XCTAssertTrue(viewModel.result.isEmpty)
        }
    }
}
