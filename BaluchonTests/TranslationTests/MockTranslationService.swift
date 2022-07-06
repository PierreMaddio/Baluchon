//
//  TranslationServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

@testable import Baluchon

// mock to simulate the service to do viewModelTests
class TranslationServiceMockSuccess: TranslationServiceProtocol {
    func getTranslation(target: String, query: String, completion: @escaping (Translation?, ErrorBaluchon?) -> (Void)) {
        let translation = Translation(data: .init(translations: [
            .init(translatedText: "Hello", detectedSourceLanguage: "FR"),
            .init(translatedText: "Welcome", detectedSourceLanguage: "FR")
        ]))
        completion(translation, nil)
    }
}

class TranslationServiceMockFailed: TranslationServiceProtocol {
    func getTranslation(target: String, query: String, completion: @escaping (Translation?, ErrorBaluchon?) -> (Void)) {
        completion(nil, .errorNetWork)
    }
}
