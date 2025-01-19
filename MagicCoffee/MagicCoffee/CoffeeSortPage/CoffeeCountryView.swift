//
//  CoffeeCountryView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 19.01.25.
//

import SwiftUI

struct CoffeeCountryView: View {
    
    @ObservedObject private var viewModel = OrderViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Select country and sort of coffee")
                    .padding()
                List {
                    ForEach(viewModel.coffeeCountries) { country in
                        Text(country.name)
                    }
                }
            }
            .poppinsFont(size: 16)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    CoffeeCountryView()
}
