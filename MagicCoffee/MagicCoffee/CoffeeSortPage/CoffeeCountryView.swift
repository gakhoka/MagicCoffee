//
//  CoffeeCountryView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 19.01.25.
//

import SwiftUI

struct CoffeeCountryView: View {
    
    @ObservedObject private var viewModel = OrderViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack(alignment: .leading) {
                Spacer()
                Text("Select country and sort of coffee")
                    .padding()
                List {
                    ForEach(viewModel.coffeeCountries) { country in
                        NavigationLink(destination: CitiesView(cities: country.cities)) {

                            Text(country.name)
                            
                        }
                    }
                }
                .poppinsFont(size: 16)
            }
            .navigationTitle("Select Country")
            .scrollContentBackground(.hidden)
            .customBackButton { dismiss() }
    }

}

#Preview {
    CoffeeCountryView()
}
