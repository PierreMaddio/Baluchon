//
//  TranslationViewModel.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class TranslationViewModel: ObservableObject {
    @Published var loaderIsVisible: Bool = false
    @Published var result: String = ""
    @Published var showAlertError = false
    
    // service
    private let service: TranslationServiceProtocol?
    
    // Inject service translate
    init(service: TranslationServiceProtocol) {
        self.service = service 
    }
    
    func fetchDataForTranslation(target: String, textToTranslate: String) {
        loaderIsVisible = true
        self.service?.getTranslation(target: target, query: textToTranslate, completion: { [weak self] translation in
            if let translatedText = translation?.data?.translations?[0].translatedText {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.result = translatedText
                }
            } else {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.result = ""
                    self?.showAlertError = true
                }
            }
        })
    }
}
