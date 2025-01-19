//
//  CoffeeCountryView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 19.01.25.
//

import SwiftUI

struct CoffeeCountryView: View {
    
    @ObservedObject private var viewModel = OrderViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
    }

    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        })  {
            Image(systemName: "arrow.left")
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    CoffeeCountryView()
}
