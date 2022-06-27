//
//  WeatherService.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void))
}

class WeatherService: ApiService, WeatherServiceProtocol {
    // func call API openweathermap, build url and make request
    func getWeather(lat: String, lon: String, completion: @escaping (Weather?) -> (Void)) {
        let urlPathStr = Path.BaseUrl.Openweathermap.path.rawValue + "?" + Path.Params.Openweathermap.lat.rawValue + "=" + lat + "&" + Path.Params.Openweathermap.lon.rawValue + "=" + lon + "&" + Constants.appID + "=" + Constants.apiKeyOpenWeathermap
        
        if let url = URL(string: urlPathStr) {
            let requestURL = self.configureRequest(api: .openWeathermap, url: url, requestType: .get)
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Weather.self, from: data) else {
                        // Failed
                        completion(nil)
                        return
                    }
                    // success
                    completion(response)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
}
