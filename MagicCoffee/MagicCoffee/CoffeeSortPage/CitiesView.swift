//
//  CitiesView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 19.01.25.
//

import SwiftUI

struct CitiesView: View {
    let cities: [Country.City]

    @ObservedObject private var viewModel = OrderViewModel()
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Select a sort of coffee")
                    .padding()
                List {
                    ForEach(cities) { city in
                        Text(city.name)
                    }
                }
            }
            .poppinsFont(size: 16)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Select City")
        .customBackButton { dismiss() }
    }
}

#Preview {
    CitiesView(cities: [Country.City(name: "")])
}
