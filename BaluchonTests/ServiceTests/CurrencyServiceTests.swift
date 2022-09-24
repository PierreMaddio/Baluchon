//
//  CurrencyServiceTest.swift
//  BaluchonTests
//
//  Created by Pierre on 21/09/2022.
//

import XCTest
@testable import Baluchon

class CurrencyServiceTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testConvertExchange() throws {
        // Currency Service. Injected with custom url session for mocking
        let currencyService = CurrencyService(urlSession: urlSession)
        
        // Set mock data
        let sampleCurrencyData = Currency(date: "2022-07-06",
                 historical: "",
                 info: .init(rate: 1.017589,
                             timestamp: 1657113036),
                 query: .init(amount: 20,
                              from: "EUR",
                              to: "USD"),
                 result: 20.35178,
                 success: true)
        
        let mockData = try JSONEncoder().encode(sampleCurrencyData)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Make mock network request to convert exchange
        currencyService.convertExchange(to: "USD", from: "EUR", amount: "20") { (currency, nil) in
            XCTAssertEqual(currency?.date, "2022-07-06")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
