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
                    Text("Currency")
                }
            TranslateView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Translate")
                }
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("Weather")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
