//
//  WeatherServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

@testable import Baluchon

// mock to simulate the service to do viewModelTests
class WeatherServiceMockSuccess: WeatherServiceProtocol {
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
        let weather = Weather(coord: .init(lon: 2.3488, lat: 48.8534),
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
        completion(weather)
    }
}

class WeatherServiceMockFailed: WeatherServiceProtocol {
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
        completion(nil)
    }
}
