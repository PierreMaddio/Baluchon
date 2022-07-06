//
//  WeatherViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class WeatherViewModelTests: XCTestCase {
    
//    func testWhenLatitudeAndLongitudeCorrespondToParisShouldGetResult() {
//        // Given
//        let mockWeatherService = WeatherServiceMockSuccess()
//        let viewModel = WeatherViewModel(service: mockWeatherService)
//        // When
//        viewModel.fetchDataForCity(lat: String(48.8534), lon: String(2.3488)) { string1, double1, string2 in
//            // Then
//            XCTAssertEqual(viewModel.cityNameDestination, "Paris")
//        }
//    }
//
//    func test_fetchDataForCity_failed() {
//        // Given
//        let mockWeatherService = WeatherServiceMockFailed()
//        let viewModel = WeatherViewModel(service: mockWeatherService)
//        // When
//        viewModel.fetchDataForCity(lat: String(48.856614), lon: String(2.3522219)) { string1, double1, string2 in
//            // Then
//            XCTAssertTrue(viewModel.loaderIsVisible)
//        }
//    }
    
    func testWhenLatitudeAndLongitudeCorrespondToCityNameShouldGetResult() {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCityDestination(lat: String(48.8534), lon: String(2.3488))
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.cityNameDestination, "Paris")
        }
    }
    
    func testWhenLatitudeAndLongitudeCorrespondToCityTemperatureShouldGetResult() {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCityDestination(lat: String(48.8534), lon: String(2.3488))
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.cityTemperatureDestination, viewModel.kelvinsToCelsius(temperature: 298.96))
        }
    }
    
    func testWhenLatitudeAndLongitudeCorrespondToCityDescriptionShouldGetResult() {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        // When
        viewModel.fetchDataForCityDestination(lat: String(48.8534), lon: String(2.3488))
        let exp = expectation(description: "test after 5 secondes")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.cityWeatherDescriptionDestination, "clear sky")
        }
    }
        
    func test_kelvinsToCelsius() {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        //When
        let result = viewModel.kelvinsToCelsius(temperature: 288.24)
        XCTAssertEqual(result, 15)
    }
}

