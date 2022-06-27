//
//  ContentView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CurrencyView(viewModel: .init(service: CurrencyService()))
                .tabItem {
                    Image(systemName: "banknote")
                    Text("tabBar_currency")
                }
            TranslationView(viewModel: .init(service: TranslationService()))
                .tabItem {
                    Image(systemName: "person.2")
                    Text("tabBar_translate")
                }
            WeatherView(viewModel: .init(service: WeatherService()))
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("tabBar_weather")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
