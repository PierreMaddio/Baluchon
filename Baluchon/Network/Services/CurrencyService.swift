//
//  CurrencyService.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

protocol CurrencyServiceProtocol {
    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?, ErrorBaluchon?) -> (Void) )
}

class CurrencyService: ApiService, CurrencyServiceProtocol {
    // call API fixer, build url and make request
    
    // session to be used to make the API call
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
            self.session = urlSession
        }
    
    func convertExchange(to: String, from: String, amount: String, completion: @escaping (Currency?, ErrorBaluchon?) -> (Void) ) {
        let urlPathStr = Path.BaseUrl.Fixer.path.rawValue + "?" + Path.Params.Fixer.to.rawValue + "=" + to + "&" + Path.Params.Fixer.from.rawValue + "=" + from + "&" + Path.Params.Fixer.amount.rawValue + "=" + amount

        if let url = URL(string: urlPathStr) {
            let requestURL = self.configureRequest(api: .fixer, url: url, requestType: .get)
            let task = session.dataTask(with: requestURL) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Currency.self, from: data) else {
                        // Failed
                        completion(nil, .errorNetWork)
                        return
                    }
                    // success
                    if response.result == nil {
                        completion(nil, .errorData)
                    } else {
                        completion(response, nil)
                    }
                } else {
                    completion(nil, .errorNetWork)
                }
            }
            task.resume()
        }
    }
}


