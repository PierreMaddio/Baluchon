//
//  WeatherServiceTests.swift
//  BaluchonTests
//
//  Created by Pierre on 24/09/2022.
//

import XCTest
@testable import Baluchon

class WeatherServiceTests: XCTestCase {
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
        let weatherService = WeatherService(urlSession: urlSession)
        // Set mock data
        let sampleWeatherData = Weather(coord: .init(lon: 2.3488, lat: 48.8534),
                                        weather: [.init(id: 800, main: "clear", weatherDescription: "clear sky", icon: "01d")],
                                        base: "stations",
                                        main: .init(temp: 298.96, feelsLike: 298.64, tempMin: 297.8, tempMax: 300.9, pressure: 1025, humidity: 40),
                                        visibility: 10000,
                                        wind: .init(speed: 5.14, deg: 310),
                                        clouds: .init(all: 0),
                                        dt: 1657116316,
                                        sys: .init(type: 2, id: 2041230, message: 34.8, country: "FR", sunrise: 1657079669, sunset: 1657137348),
                                        timezone: 7200,
                                        id: 2988507,
                                        name: "Paris",
                                        cod: 200)
        
        let mockData = try JSONEncoder().encode(sampleWeatherData)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        weatherService.getWeather(latitude: "48.8534", longitude: "2.3488") { weather in
            XCTAssertEqual(weather?.name, "Paris")
            XCTAssertEqual(weather?.base, "stations")
            //XCTAssertEqual(weather?.main?.temp, 298.96)
            //XCTAssertEqual(weather?.visibility, 10000)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
