//
//  TranslationService.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

protocol TranslationServiceProtocol: Service {
    func getTranslation(target: String, q: String, completion: @escaping (Translation?) -> (Void))
}

class TranslateService: ApiService, TranslationServiceProtocol {
    
    func getTranslation(target: String, q: String, completion: @escaping (Translation?) -> (Void)) {
        let urlPathStr = Path.BaseUrl.GoogleTranslate.path.rawValue + "?" + Path.Params.GoogleTranslate.target.rawValue + "=" + target + "&" + Path.Params.GoogleTranslate.q.rawValue + "=" + q + "&" + Constants.keyGoogle + "=" + Constants.apiGoogleTranslate
        
        if let url = URL(string: urlPathStr) {
            let requestURL = self.configureRequest(api: .googleTranslate, url: url, requestType: .get)
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Translation.self, from: data) else {
                        // Failed
                        completion(nil)
                        return
                    }
                    // success
                    completion(response)
                }
            }
            task.resume()
        }
    }
}
