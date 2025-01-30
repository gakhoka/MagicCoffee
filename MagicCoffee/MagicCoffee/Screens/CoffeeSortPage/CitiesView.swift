//
//  CitiesView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 19.01.25.
//

import SwiftUI

struct CitiesView: View {
    
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var path: NavigationPath
    let cities: [Country.City]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Select a sort of coffee")
                    .padding()
                List {
                    ForEach(cities) { city in
                        HStack {
                            Text(city.name)
                                .foregroundColor(viewModel.selectedCity == city.name ? .brown : .black)
                                .scaleEffect(viewModel.selectedCity == city.name ? 1.1 : 1)
                                .animation(.easeInOut(duration: 0.4), value: viewModel.selectedCity == city.name)
                                .onTapGesture {
                                    viewModel.selectedCity = city.name
                            }
                            
                            Spacer()
                            if viewModel.selectedCity == city.name {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.brownColor)
                                    .imageScale(.large)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.nardoGray)
                                    .imageScale(.large)
                                
                            }
                        }
                        .contentShape(Rectangle())
                        .padding(6)
                        .onTapGesture {
                            viewModel.toggleCitySelection(city.name)
                        }
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

//#Preview {
//    CitiesView(viewModel: OrderViewModel(), path: .constant(NavigationPath()), cities: [Country.City])
//}
