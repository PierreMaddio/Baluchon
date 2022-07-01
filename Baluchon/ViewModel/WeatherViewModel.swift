//
//  WeatherViewModel.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var loaderIsVisible: Bool = false
    @Published var cityNameDestination: String = ""
    @Published var cityTemperatureDestination: Double = 0.0
    @Published var cityWeatherDescriptionDestination: String = ""
    @Published var cityNameOrigin: String = ""
    @Published var cityTemperatureOrigin: Double = 0.0
    @Published var cityWeatherDescriptionOrigin: String = ""
    @Published var showAlertError = false
    
    // service
    private let service: WeatherServiceProtocol?
    
    // Inject service weather
    init(service: WeatherServiceProtocol) {
        self.service = service 
    }
    
    // when using completion with @escaping: [weak self] to release the memory
    func fetchDataForCity(lat: String, lon: String, handler: @escaping (String, Double, String)-> (Void) ) {
        loaderIsVisible = true
        self.service?.getWeather(lat: lat, lon: lon, completion: { [weak self] weatherData in
            if let cityName = weatherData?.name,
               let cityTemperature = weatherData?.main?.temp,
               let cityWeatherDescription = weatherData?.weather?[0].weatherDescription {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    handler(cityName, cityTemperature, cityWeatherDescription)
                }
            } else {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.showAlertError = true
                }
            }
        })
    }
    
    func fetchDataForCityDestination(lat: String, lon: String) {
        self.fetchDataForCity(lat: lat, lon: lon) { cityName, cityTemperature, cityWeatherDescription in
            self.cityNameDestination = cityName
            self.cityTemperatureDestination = self.kelvinsToCelsius(temperature: cityTemperature) 
            self.cityWeatherDescriptionDestination = cityWeatherDescription
        }
    }
    
    func fetchDataForCityOrigin(lat: String, lon: String) {
        self.fetchDataForCity(lat: lat, lon: lon) { cityName, cityTemperature, cityWeatherDescription in
            self.cityNameOrigin = cityName
            self.cityTemperatureOrigin = self.kelvinsToCelsius(temperature: cityTemperature)
            self.cityWeatherDescriptionOrigin = cityWeatherDescription
        }
    }
    
    func kelvinsToCelsius(temperature: Double) -> Double {
        let conversion = temperature - 273.15
        let aroundConversion = conversion.rounded()
        return aroundConversion
    }

}
