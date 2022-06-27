//
//  TranslationViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class TranslationViewModelTests: XCTestCase {

    func testFetchDataForTranslation_success() throws {
        // Given
        let mockTranslationService = TranslationServiceMockSuccess()
        let viewModel = TranslationViewModel(service: mockTranslationService)
        // When
        viewModel.fetchDataForTranslation(target: "FR", textToTranslate: "Hello")
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            // Then
            XCTAssertEqual(viewModel.result, "Bonjour")
            XCTAssertTrue(mockTranslationService.getTranslationIsCalled)
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertFalse(viewModel.loaderIsError)
        }
    }
    
    func testFetchDataForTranslation_failed() throws {
        // Given
        let mockTranslationService = TranslationServiceMockFailed()
        let viewModel = TranslationViewModel(service: mockTranslationService)
        // When
        viewModel.fetchDataForTranslation(target: "FR", textToTranslate: "Hello")
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            // Then
            XCTAssertTrue(mockTranslationService.getTranslationIsCalled)
            XCTAssertTrue(viewModel.result.isEmpty)
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertFalse(viewModel.loaderIsError)
        }
    }
}

// mock to simulate the service to do viewModelTests
class TranslationServiceMockSuccess: TranslationServiceProtocol {
    var getTranslationIsCalled = false
    
    func getTranslation(target: String, query: String, completion: @escaping (Translation?) -> (Void)) {
        getTranslationIsCalled = true
        
        let translation = Translation(data: .init(translations: [
            .init(translatedText: "Bonjour", detectedSourceLanguage: "EN"),
            .init(translatedText: "Merci", detectedSourceLanguage: "EN")
        ]))
        completion(translation)
    }
}

class TranslationServiceMockFailed: TranslationServiceProtocol {
    var getTranslationIsCalled = false
    
    func getTranslation(target: String, query: String, completion: @escaping (Translation?) -> (Void)) {
        getTranslationIsCalled = true
        completion(nil)
    }
}
