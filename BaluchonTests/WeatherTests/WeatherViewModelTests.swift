//
//  WeatherViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class WeatherViewModelTests: XCTestCase {
    
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
        
    func testConvertionKelvinsToCelsiusSuccess() {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        
        //When
        let result = viewModel.kelvinsToCelsius(temperature: 288.24)
        
        // Then
        XCTAssertEqual(result, 15)
    }

}

