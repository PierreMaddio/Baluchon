//
//  WeatherView.swift
//  Baluchon
//
//  Created by Pierre on 19/06/2022.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            if viewModel.loaderIsVisible {
                LoaderView()
                    .frame(width: 80, height: 80)
            } else {
                VStack(alignment: .center, spacing: 0.0) {
                    
                    Spacer()
                    
                    HStack {
                        Spacer(minLength: 15)
                        VStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text($viewModel.cityNameDestination.wrappedValue)
                                    .bold()
                                    .font(.title)
                                Text($viewModel.cityWeatherDescriptionDestination.wrappedValue)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                VStack(spacing: 20) {
                                        Image("usa")
                                        .resizable()
                                        .frame(width: 100, height: 50)
                                }
                                .frame(width: 150, alignment: .leading)
                                Text(String(format: "%0.f", $viewModel.cityTemperatureDestination.wrappedValue) + "°")

                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .padding()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.lightGray))
                        Spacer(minLength: 15)
                    }
                    
                    
                    Spacer()
                    
                    Button("Refresh") {
                        fetchDataForNewYork()
                        fetchDataForParis()
                    }
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .clipShape(Capsule())
                    
                    Spacer()

                    
                    HStack {
                        Spacer(minLength: 15)
                        VStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text($viewModel.cityNameOrigin.wrappedValue)
                                    .bold()
                                    .font(.title)
                                Text($viewModel.cityWeatherDescriptionOrigin.wrappedValue)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                VStack(spacing: 20) {
                                    Image("france")
                                        .resizable()
                                        .frame(width: 100, height: 50)
                                }
                                .frame(width: 150, alignment: .leading)
                                Text(String(format: "%0.f", $viewModel.cityTemperatureOrigin.wrappedValue) + "°")
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .padding()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.lightGray))
                        Spacer(minLength: 15)
                    }
                    Spacer()
                }
                .foregroundColor(.blue)
                .navigationTitle(Text("Weather"))
            }
        }.onAppear {
            fetchDataForNewYork()
            fetchDataForParis()
        }
    }
    
    func fetchDataForNewYork() {
        viewModel.fetchDataForCityDestination(lat: "40.7127281", lon: "-74.0060152")
    }
    
    func fetchDataForParis() {
        viewModel.fetchDataForCityOrigin(lat: "48.8534100", lon: "2.3488000")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: .init(service: WeatherService()))
    }
}

