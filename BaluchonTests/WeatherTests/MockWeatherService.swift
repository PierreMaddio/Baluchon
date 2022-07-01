//
//  WeatherServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

import Foundation
@testable import Baluchon

// mock to simulate the service to do viewModelTests
class WeatherServiceMockSuccess: WeatherServiceProtocol {
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
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
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
        completion(nil)
    }
}
