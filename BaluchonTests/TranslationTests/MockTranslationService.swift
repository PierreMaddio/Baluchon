//
//  TranslationServiceMock.swift
//  BaluchonTests
//
//  Created by Pierre on 30/06/2022.
//

import Foundation
@testable import Baluchon

// mock to simulate the service to do viewModelTests
class TranslationServiceMockSuccess: TranslationServiceProtocol {
    var getTranslationIsCalled = false
    
    func getTranslation(target: String, query: String, completion: @escaping (Translation?) -> (Void)) {
        getTranslationIsCalled = true
        
        let translation = Translation(data: .init(translations: [
            .init(translatedText: "Bonjour", detectedSourceLanguage: "EN"),
            .init(translatedText: "Merci", detectedSourceLanguage: "EN")
        ]))
        completion(translation)
    }
}

class TranslationServiceMockFailed: TranslationServiceProtocol {
    var getTranslationIsCalled = false
    
    func getTranslation(target: String, query: String, completion: @escaping (Translation?) -> (Void)) {
        getTranslationIsCalled = true
        completion(nil)
    }
}
