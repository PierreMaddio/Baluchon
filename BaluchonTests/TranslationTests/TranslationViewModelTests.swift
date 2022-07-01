//
//  TranslationViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class TranslationViewModelTests: XCTestCase {

//    func test_fetchDataForTranslation_success() throws {
//        // Given
//        let mockTranslationService = TranslationServiceMockSuccess()
//        let viewModel = TranslationViewModel(service: mockTranslationService)
//        // When
//        viewModel.fetchDataForTranslation(target: "FR", textToTranslate: "Hello")
//        let exp = expectation(description: "test after 5 secondes")
//        let result = XCTWaiter.wait(for: [exp], timeout: 5)
//        if result == XCTWaiter.Result.timedOut {
//            // Then
//            XCTAssertEqual(viewModel.result, "Bonjour")
//            XCTAssertTrue(mockTranslationService.getTranslationIsCalled)
//            XCTAssertFalse(viewModel.loaderIsVisible)
//        }
//    }
    
    func testGetTranslationForBonjourShouldGetHello() throws {
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
    
//    func testGetTranslationForBienvenueShouldGetWelcome() throws {
//        // Given
//        let mockTranslationService = TranslationServiceMockSuccess()
//        let viewModel = TranslationViewModel(service: mockTranslationService)
//        // When
//        viewModel.fetchDataForTranslation(target: "EN", textToTranslate: "Bienvenue")
//        let exp = expectation(description: "test after 5 secondes")
//        let result = XCTWaiter.wait(for: [exp], timeout: 5)
//        // Then
//        if result == XCTWaiter.Result.timedOut {
//            XCTAssertEqual(viewModel.result, "Welcome")
//            XCTAssertTrue(mockTranslationService.getTranslationIsCalled)
//            XCTAssertFalse(viewModel.loaderIsVisible)
//        }
//    }
    
//    func test_fetchDataForTranslation_failed() throws {
//        // Given
//        let mockTranslationService = TranslationServiceMockFailed()
//        let viewModel = TranslationViewModel(service: mockTranslationService)
//        // When
//        viewModel.fetchDataForTranslation(target: "FR", textToTranslate: "Hello")
//        let exp = expectation(description: "test after 5 secondes")
//        let result = XCTWaiter.wait(for: [exp], timeout: 5)
//        if result == XCTWaiter.Result.timedOut {
//            // Then
//            XCTAssertTrue(mockTranslationService.getTranslationIsCalled)
//            XCTAssertTrue(viewModel.result.isEmpty)
//            XCTAssertFalse(viewModel.loaderIsVisible)
//        }
//    }
}
