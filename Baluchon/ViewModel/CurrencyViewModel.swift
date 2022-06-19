//
//  CurrencyViewModel.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    @Published var loaderIsVisible: Bool = false
    @Published var loaderIsError: Bool = false
    
    // service
    let service: CurrencyServiceProtocol?
    
    // Inject service currency
    init(service: Service) {
        self.service = service as? CurrencyServiceProtocol
    }
    
    func loadData(to: String, from: String, amount: String, completion: @escaping ((String) -> Void) ) {
        loaderIsVisible = true
        self.service?.convertExchange(to: to, from: from, amount: amount, completion: { currencyExchange in
            if let currency = currencyExchange?.result {
                DispatchQueue.main.async {
                    self.loaderIsVisible = false
                    self.loaderIsError = false
                    completion("\(currency) \(to)")
                }
            } else {
                self.loaderIsError = true
            }
        })
    }
}
