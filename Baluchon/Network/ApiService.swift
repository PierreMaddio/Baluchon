//
//  ApiService.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

open class ApiService {
    
    enum API {
        case fixer
        case openWeathermap
        case googleTranslate
    }
    
    enum Constants {
        static let headerContentType = "Content-Type"
        static let headerAuthorization = "Authorization"
        static let contentTypeJson = "application/json"
        
        static let apiKey = "apikey"
        static let apiKeyFixer = "fwnt4RIn25TfKcqnqXfc5ghD2NcE99Ig"
        
        static let appID = "appid"
        static let apiKeyOpenWeathermap = "074b276c5f07fc244358b814afab7bbf"
        
        static let keyGoogle = "key"
        static let apiGoogleTranslate = "AIzaSyAEIm9kFV5fnrwDcibD40s-_wOo7qg1ArE"
    }
    
    enum RequestType {
        case get
        case post
    }
    
    enum ContentType {
        case json
    }
    
    enum Path{
        
        enum BaseUrl {
            // FIXER API
            enum Fixer: String {
                case path = "https://api.apilayer.com/fixer/convert"
            }
            // OpenWeathermap API
            enum Openweathermap: String {
                case path = "https://api.openweathermap.org/data/2.5/weather"
            }
            // GoogleTranslate API
            enum GoogleTranslate: String {
                case path = "https://translation.googleapis.com/language/translate/v2"
            }
        }
        
        enum Params {
            // FIXER API
            enum Fixer: String {
                case to = "to"
                case from = "from"
                case amount = "amount"
            }
            // OpenWeathermap API
            enum Openweathermap: String {
                case lat = "lat"
                case lon = "lon"
            }
            // GoogleTranslate API
            enum GoogleTranslate: String {
                case target = "target"
                case q = "q"
            }
        }
    }
}

// MARK: - Private method
extension ApiService {
    func configureRequest(api: API,url: URL, requestType: RequestType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch requestType {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        }
        
        request.setValue(Constants.contentTypeJson, forHTTPHeaderField: Constants.headerContentType)
        
        if api == .fixer {
            request.setValue(Constants.apiKeyFixer, forHTTPHeaderField: Constants.apiKey)
        }
        
        return request
    }
}
