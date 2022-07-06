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
    @Published var showAlertErrorData = false
    
    // service
    private let service: TranslationServiceProtocol?
    
    // Inject service translate
    init(service: TranslationServiceProtocol) {
        self.service = service 
    }
    
    func fetchDataForTranslation(target: String, textToTranslate: String) {
        loaderIsVisible = true
        self.service?.getTranslation(target: target, query: textToTranslate, completion: { [weak self] translation, error in
            if let translatedText = translation?.data?.translations?[0].translatedText {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.result = translatedText
                }
            } else {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.result = ""
                    if error == .errorNetWork {
                        self?.showAlertError = true
                    } else {
                        self?.showAlertErrorData = true
                    }
                }
            }
        })
    }
}
