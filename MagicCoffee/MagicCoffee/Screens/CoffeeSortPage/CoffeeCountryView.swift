//
//  CoffeeCountryView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 19.01.25.
//

import SwiftUI

struct CoffeeCountryView: View {
    
    @ObservedObject var countriesViewModel: CountriesViewModel
    @ObservedObject  var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Select country and sort of coffee")
                .padding()
            if countriesViewModel.countries.isEmpty {
                Text("Error loading countries, please check your connection")
                    .poppinsFont(size: 24)
                    .foregroundStyle(.primary)
            } else {
                List {
                    ForEach(countriesViewModel.countries) { country in
                        NavigationLink(destination: CitiesView(viewModel: viewModel, path: $path, cities: country.cities)) {
                            Text(country.name)
                        }
                    }
                }
                .poppinsFont(size: 16)
            }
        }
        .navigationTitle("Select Country")
        .scrollContentBackground(.hidden)
        .customBackButton { dismiss() }
    }
    
}

#Preview {
    CoffeeCountryView(countriesViewModel: CountriesViewModel(), viewModel: OrderViewModel(), path: .constant(NavigationPath()))
}
