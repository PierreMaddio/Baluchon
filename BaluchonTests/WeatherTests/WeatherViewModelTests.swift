//
//  WeatherViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class WeatherViewModelTests: XCTestCase {
    
    func test_fetchDataForCity_success() throws {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCity(lat: String(48.856614), lon: String(2.3522219)) { string1, double1, string2 in
            // Then
            XCTAssertTrue(mockWeatherService.getWeatherIsCalled)
            XCTAssertFalse(viewModel.loaderIsVisible)
            XCTAssertFalse(viewModel.loaderIsError)
        }
    }
    
    func test_fetchDataForCity_failed() throws {
        // Given
        let mockWeatherService = WeatherServiceMockFailed()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCity(lat: String(48.856614), lon: String(2.3522219)) { string1, double1, string2 in
            // Then
            XCTAssertTrue(mockWeatherService.getWeatherIsCalled)
            XCTAssertTrue(viewModel.loaderIsVisible)
            XCTAssertTrue(viewModel.loaderIsError)
        }
    }
    
    func test_fetchDataForCityDestination() throws {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCityDestination(lat: String(48.856614), lon: String(2.3522219))
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.cityNameDestination, "Saint-Merri")
            XCTAssertEqual(viewModel.cityTemperatureDestination, viewModel.kelvinsToCelsius(temperature: 288.24))
            XCTAssertEqual(viewModel.cityWeatherDescriptionDestination, "clear sky")
        }
        // wait for completion excecution cityDestination
    }
    
    func test_fetchDataForCityOrigin() throws {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCityOrigin(lat: String(48.856614), lon: String(2.3522219))
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.cityNameOrigin, "Saint-Merri")
            XCTAssertEqual(viewModel.cityTemperatureOrigin, viewModel.kelvinsToCelsius(temperature: 288.24))
            XCTAssertEqual(viewModel.cityWeatherDescriptionOrigin, "clear sky")
        }
        // wait for completion excecution cityOrigin
    }
    
    func test_kelvinsToCelsius() throws {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        //When
        let result = viewModel.kelvinsToCelsius(temperature: 288.24)
        XCTAssertEqual(result, 15)
    }
}

