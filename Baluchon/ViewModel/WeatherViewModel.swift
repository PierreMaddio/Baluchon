//
//  WeatherViewModel.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var loaderIsVisible: Bool = false
    @Published var loaderIsError: Bool = false
    @Published var cityNameDestination: String = ""
    @Published var cityTemperatureDestination: String = ""
    @Published var cityWeatherDescriptionDestination: String = ""
    @Published var cityNameOrigin: String = ""
    @Published var cityTemperatureOrigin: String = ""
    @Published var cityWeatherDescriptionOrigin: String = ""
    
    // service
    let service: WeatherServiceProtocol?
    
    // Inject service weather
    init(service: Service) {
        self.service = service as? WeatherServiceProtocol
    }
    
    private func fetchDataForCity(lat: String, lon: String, handler: @escaping (String,String, String)-> (Void) ) {
        loaderIsVisible = true
        self.service?.getWeather(lat: lat, lon: lon, completion: { weatherData in
            if let cityName = weatherData?.name,
               let cityTemperature = weatherData?.main?.temp,
               let cityWeatherDescription = weatherData?.weather?[0].weatherDescription {
                DispatchQueue.main.async {
                    self.loaderIsVisible = false
                    self.loaderIsError = false
                    handler(cityName,"\(cityTemperature )", cityWeatherDescription)
                }
            } else {
                self.loaderIsError = true
            }
        })
    }
    
    func fetchDataForCityDestination(lat: String, lon: String) {
        self.fetchDataForCity(lat: lat, lon: lon) { cityName, cityTemperature, cityWeatherDescription in
            self.cityNameDestination = cityName
            self.cityTemperatureDestination = cityTemperature
            self.cityWeatherDescriptionDestination = cityWeatherDescription
        }
    }
    
    func fetchDataForCityOrigin(lat: String, lon: String) {
        self.fetchDataForCity(lat: lat, lon: lon) { cityName, cityTemperature, cityWeatherDescription in
            self.cityNameOrigin = cityName
            self.cityTemperatureOrigin = cityTemperature
            self.cityWeatherDescriptionOrigin = cityWeatherDescription
        }
    }
}
