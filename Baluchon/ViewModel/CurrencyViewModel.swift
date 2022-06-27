//
//  CurrencyViewModel.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    // @Published if the property change, it refresh directly in the view
    @Published var loaderIsVisible: Bool = false
    @Published var loaderIsError: Bool = false
    
    // service
    private let service: CurrencyServiceProtocol?
    
    // Inject service currency
    init(service: CurrencyServiceProtocol) {
        self.service = service 
    }
    
    func loadData(to: String, from: String, amount: String, completion: @escaping ((String) -> Void) ) {
        loaderIsVisible = true
        self.service?.convertExchange(to: to, from: from, amount: amount, completion: { [weak self] currencyExchange in
            if let currency = currencyExchange?.result {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.loaderIsError = false
                    completion("\(currency) \(to)")
                }
            } else {
                DispatchQueue.main.async {
                    self?.loaderIsVisible = false
                    self?.loaderIsError = false
                    completion("")
                }
            }
        })
    }
}
