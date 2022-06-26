//
//  WeatherViewModelTests.swift
//  BaluchonTests
//
//  Created by Pierre on 26/06/2022.
//

import XCTest
@testable import Baluchon

class WeatherViewModelTests: XCTestCase {
    
    func testFetchDataForCity_success() throws {
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
    
    func testFetchDataForCity_failed() throws {
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
    
    func testFetchDataForCityDestination() throws {
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
    
    func testFetchDataForCityOrigin() throws {
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
    
    func testKelvinsToCelsius() throws {
        // Given
        let mockWeatherService = WeatherServiceMockSuccess()
        let viewModel = WeatherViewModel(service: mockWeatherService)
        //When
        let result = viewModel.kelvinsToCelsius(temperature: 288.24)
        XCTAssertEqual(result, 15)
    }
}


class WeatherServiceMockSuccess: WeatherServiceProtocol {
    var getWeatherIsCalled = false
    
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
        getWeatherIsCalled = true
        
        let weather = Weather(coord: .init(lon: 2.3522, lat: 48.8566),
                              weather: [.init(id: 800, main: "clear", weatherDescription: "clear sky", icon: "01d")],
                              base: "stations",
                              main: .init(temp: 288.24, feelsLike: 287.95, tempMin: 286.44, tempMax: 289.2, pressure: 1015, humidity: 82),
                              visibility: 10000,
                              wind: .init(speed: 1.03, deg: 0),
                              clouds: .init(all: 0),
                              dt: 1656227700,
                              sys: .init(type: 2, id: 2041230, message: 34.8, country: "FR", sunrise: 1656215305, sunset: 1656273493),
                              timezone: 7200,
                              id: 2978048,
                              name: "Saint-Merri",
                              cod: 200)
        completion(weather)
    }
}

class WeatherServiceMockFailed: WeatherServiceProtocol {
    var getWeatherIsCalled = false
    
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
        getWeatherIsCalled = true
        completion(nil)
    }
}
