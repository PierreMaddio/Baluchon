//
//  TranslationViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class TranslationViewModelTests: XCTestCase {
    
    func testGetTranslationForBonjourShouldGetHello() {
        // Given
        let mockTranslationService = TranslationServiceMockSuccess()
        let viewModel = TranslationViewModel(service: mockTranslationService)
        // When
        viewModel.fetchDataForTranslation(target: "EN", textToTranslate: "Bonjour")
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.result, "Hello")
            XCTAssertFalse(viewModel.loaderIsVisible)
        }
    }
    
    func testGetTranslationForBonjourShouldFailed() {
        // Given
        let mockTranslationService = TranslationServiceMockFailed()
        let viewModel = TranslationViewModel(service: mockTranslationService)
        // When
        viewModel.fetchDataForTranslation(target: "EN", textToTranslate: "Bonjour")
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotEqual(viewModel.result, "Hello")
            XCTAssertTrue(viewModel.result.isEmpty)
        }
    }
}
