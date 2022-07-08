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
            if viewModel.loaderIsVisible {
                LoaderView()
                    .frame(width: 80, height: 80)
            } else {
                Form {
                    Section(header: Text("translation_section_1_title")) {
                        TextField("translation_text_1_placeholder", text: $textToTranslate)
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                            .keyboardType(.default)
                    }
                    
                    Button("translation_label_button") {
                        if !textToTranslate.isEmpty {
                            viewModel.fetchDataForTranslation(target: "en", textToTranslate: textToTranslate)
                        } else {
                            showAlert = true
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .clipShape(Capsule())
                    .alert("translation_server_alert", isPresented: $viewModel.showAlertError) {
                        Button("Ok", role: .cancel) {}
                    }
                    .alert("translation_text_alert", isPresented: $showAlert) {
                        Button("Ok", role: .cancel) {}
                    }
                    .alert("translation_server_alert_data", isPresented: $viewModel.showAlertErrorData) {
                        Button("Ok", role: .cancel) {}
                    }
                    
                    
                    Section(header: Text("translation_section_2_title")) {
                        TextField("translation_text_2_placeholder", text: $viewModel.result)
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                            .keyboardType(.default)
                    }
                }
                .navigationTitle(Text("tabBar_translate"))
            }
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(viewModel: .init(service: TranslationService()))
    }
}
