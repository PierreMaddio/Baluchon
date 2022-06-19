//
//  TranslationViewModel.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class TranslationViewModel: ObservableObject {
    @Published var loaderIsVisible: Bool = false
    @Published var loaderIsError: Bool = false
    @Published var result: String = ""
    
    // service
    let service: TranslationServiceProtocol?


    // Inject service translate
    init(service: Service) {
        
        self.service = service as? TranslationServiceProtocol
    }
    
    func fetchDataForTranslation(target: String, q: String) {
        loaderIsVisible = true
        self.service?.getTranslation(target: target, q: q, completion: { translation in
            if let translatedText = translation?.data?.translations?[0].translatedText {
                DispatchQueue.main.async {
                    self.loaderIsVisible = false
                    self.loaderIsError = false
                    self.result = translatedText
                }
            } else {
                self.loaderIsError = true
            }
        })
    }
}