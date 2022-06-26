//
//  TranslationService.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

protocol TranslationServiceProtocol: Service {
    func getTranslation(target: String, query: String, completion: @escaping (Translation?) -> (Void))
}

class TranslationService: ApiService, TranslationServiceProtocol {
    
    // .trimmingCharacters(in: .whitespacesAndNewlines) delete spaces at the beginning and at the end of the query
    // %20 equals to a space in a url and + = %20
    // replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    func getTranslation(target: String, query: String, completion: @escaping (Translation?) -> (Void)) {
        let urlPathStr = Path.BaseUrl.GoogleTranslate.path.rawValue + "?" + Path.Params.GoogleTranslate.target.rawValue + "=" + target + "&" + Path.Params.GoogleTranslate.q.rawValue + "=" + query.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil) + "&" + Constants.keyGoogle + "=" + Constants.apiGoogleTranslate
        
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
