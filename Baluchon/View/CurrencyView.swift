//
//  CurrencyView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import SwiftUI

struct CurrencyView: View {
    @ObservedObject var viewModel: CurrencyViewModel
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
    }
    
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
                            Section(header: Text("Convert a currency")) {
                                TextField("Entrer an amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                
                                Picker(selection: $itemSelected, label: Text("FROM")) {
                                    ForEach(0 ..< currencies.count) { index in
                                        Text(self.currencies[index]).tag(index)
                                    }
                                }
                                Picker(selection: $itemSelected2, label: Text("TO")) {
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
                        }
                        .navigationTitle(Text("Currency"))
                        .foregroundColor(Color.blue)
                    }
                }
            }
        }
    }
    
    func convertData() {
        viewModel.loadData(to: currencies[itemSelected2], from: currencies[itemSelected], amount: amount) { conversionResult in
            self.result = conversionResult
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(viewModel: .init(service: CurrencyService()))
    }
}
