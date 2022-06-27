//
//  TranslationView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import SwiftUI

struct TranslationView: View {
    @State private var textToTranslate = ""
    @State private var translatedText = ""
    @State private var showAlert = false
    
    @ObservedObject var viewModel: TranslationViewModel
    
    init(viewModel: TranslationViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Translate")) {
                    TextField("Text in french", text: $textToTranslate)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                        .keyboardType(.default)
                }
                
                Button("Translate") {
                    if !textToTranslate.isEmpty {
                        viewModel.fetchDataForTranslation(target: "en", textToTranslate: textToTranslate)
                       
                    } else {
                        showAlert = true
                    }
                }
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                .alert("Server Error", isPresented: $viewModel.showAlertError) {
                    Button("Ok", role: .cancel) {
                        
                    }
                }
                .alert("Enter text", isPresented: $showAlert) {
                    Button("Ok", role: .cancel) {
                        
                    }
                }
                
                Section(header: Text("Translation")) {
                    TextField("Translation in english", text: $viewModel.result)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                        .keyboardType(.default)
                }
            }
            .navigationTitle(Text("tabBar_translate"))
            .foregroundColor(Color.blue)
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(viewModel: .init(service: TranslationService()))
    }
}
