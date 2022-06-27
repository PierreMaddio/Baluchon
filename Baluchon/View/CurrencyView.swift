//
//  CurrencyView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import SwiftUI
import Combine

struct CurrencyView: View {
    // @ObservedObject to can accept @Published properties
    // The ObservableObject conformance allows instances of this class to be used inside views, so that when important changes happen the view will reload.
    @ObservedObject var viewModel: CurrencyViewModel
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
    }
    
    // @State: local change
    @State private var showAlert = false
    @State private var showAlertError = false
    @State private var itemSelected = 0
    @State private var itemSelected2 = 1
    @State private var amount: String = ""
    @State private var result: String = ""
    private let currencies = ["EUR", "USD"]
    
    var body: some View {
        NavigationView {
            if viewModel.loaderIsVisible {
                LoaderView()
                    .frame(width: 80, height: 80)
            } else {
                VStack {
                    if viewModel.loaderIsError {
                        Text("ERROR")
                    } else {
                        Form {
                            Section(header: Text("section_1_title_currency")) {
                                TextField("currency_amount_placeholder", text: $amount)
                                    .keyboardType(.decimalPad)
                                
                                Picker(selection: $itemSelected, label: Text("currency_from_title")) {
                                    ForEach(0 ..< currencies.count) { index in
                                        Text(self.currencies[index]).tag(index)
                                    }
                                }
                                Picker(selection: $itemSelected2, label: Text("currency_to_title")) {
                                    ForEach(0 ..< currencies.count) { index in
                                        Text(self.currencies[index]).tag(index)
                                    }
                                }
                            }
                            Section(header: Text("Conversion")) {
                                Text(result)
                            }
                            
                            Button("Convert") {
                                convertData()
                            }
                            .padding()
                            .background(Color(red: 0, green: 0, blue: 0.5))
                            .clipShape(Capsule())
                            .alert("Enter an amount", isPresented: $showAlert) {
                                Button("Ok", role: .cancel) {
                                }
                            }
                            .alert("Server error", isPresented: $showAlertError) {
                                Button("Ok", role: .cancel) {
                                }
                            }
                        }
                        .navigationTitle(Text("tabBar_currency"))
                        .foregroundColor(Color.blue)
                    }
                }
            }
        }
    }
    
    func convertData() {
        if !amount.isEmpty {
            viewModel.loadData(to: currencies[itemSelected2], from: currencies[itemSelected], amount: amount) { conversionResult in
                if conversionResult.isEmpty {
                    showAlertError = true
                } else {
                    self.result = conversionResult
                }
                
            }
        } else {
            
            showAlert = true
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(viewModel: .init(service: CurrencyService()))
    }
}
