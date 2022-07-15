//
//  CurrencyView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import SwiftUI

struct CurrencyView: View {
    // @ObservedObject accept @Published properties
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
                    Form {
                        Section(header: Text("currency_section_1_title")) {
                            TextField("currency_amount_placeholder", text: $amount)
                                .keyboardType(.decimalPad)
                                .submitLabel(.done)
                            
                            Picker(selection: $itemSelected, label: Text("currency_from_title")) {
                                ForEach(0 ..< currencies.count, id: \.self) { index in
                                    Text(self.currencies[index]).tag(index)
                                }
                            }
                            Picker(selection: $itemSelected2, label: Text("currency_to_title")) {
                                ForEach(0 ..< currencies.count, id: \.self) { index in
                                    Text(self.currencies[index]).tag(index)
                                }
                            }
                        }
                        Section(header: Text("Conversion")) {
                            Text(result)
                        }
                        
                        Button("currency_label_button") {
                            convertData()
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .clipShape(Capsule())
                        .alert("currency_amount_alert", isPresented: $showAlert) {
                            Button("Ok", role: .cancel) {}
                        }
                        .alert("currency_server_alert", isPresented: $showAlertError) {
                            Button("Ok", role: .cancel) {}
                        }
                        .alert("translation_server_alert_data", isPresented: $viewModel.showAlertErrorData) {
                            Button("Ok", role: .cancel) {}
                        }
                    }
                    .navigationTitle(Text("tabBar_currency"))
                    .foregroundColor(Color.blue)
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
