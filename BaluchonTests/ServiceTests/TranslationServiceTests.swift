//
//  TranslationServiceTests.swift
//  BaluchonTests
//
//  Created by Pierre on 24/09/2022.
//

import XCTest
@testable import Baluchon

//class TranslationServiceTests: XCTestCase {
//    // custom urlsession for mock network calls
//    var urlSession: URLSession!
//
//    override func setUpWithError() throws {
//        // Set url session for mock networking
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [MockURLProtocol.self]
//        urlSession = URLSession(configuration: configuration)
//    }
//    
//    func testgetTranslation() throws {
//        // Currency Service. Injected with custom url session for mocking
//        let translationService = TranslationService(urlSession: urlSession)
//        
//        // Set mock data
//        let sampleTranslationData =  Translation(data: .init(translations: [
//            .init(translatedText: "Hello", detectedSourceLanguage: "FR"),
//            .init(translatedText: "Welcome", detectedSourceLanguage: "FR")
//        ]))
//        
//        let mockData = try JSONEncoder().encode(sampleTranslationData)
//        
//        // Return data in mock request handler
//        MockURLProtocol.requestHandler = { request in
//            return (HTTPURLResponse(), mockData)
//        }
//        
//        // Set expectation. Used to test async code.
//        let expectation = XCTestExpectation(description: "response")
//        
//        // Make mock network request to convert exchange
//        translationService.getTranslation(target: "en", query: "Bonjour") { (translation, nil) in
//            XCTAssertEqual(translation?.data?.translations?[0].detectedSourceLanguage, "Hello")
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1)
//    }
//}
