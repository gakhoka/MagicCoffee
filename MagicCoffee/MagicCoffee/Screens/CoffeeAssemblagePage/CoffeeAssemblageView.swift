//
//  CoffeeAssemblageView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CoffeeAssemblageView: View {
    
    
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var path: NavigationPath
    @State var AllmilkTypes = ["None", "Regular", "Lactose-free", "Skimmed", "Vegetable"]
    @State var AllsyrupTypes = ["None", "Amaretto", "Coconut", "Vanilla", "Caramel"]
    var coffee: Coffee
    
    var body: some View {
        VStack {
            ScrollView {
                coffeeType
                Divider()
                coffeeSort
                Divider()
                roasting
                Divider()
                grinding
                Divider()
                milkType
                Divider()
                syrup
                Divider()
                additives
                Divider()
                ice
            }
            .scrollIndicators(.hidden)
            totalAmountNextButton
        }
        .poppinsFont(size: 16)
        .foregroundStyle(.black)
        .sheet(isPresented: $viewModel.isMilkSelectionTapped) {
            milkSheet
        }
        .sheet(isPresented: $viewModel.isSyrupSelectionTapped) {
            syrupSheet
        }
        .navigationTitle("Coffee Lover Assemblage")
        .customBackButton {
            dismiss()
        }
        .onAppear(perform: viewModel.fetchCountries)
    }
    
    private var milkSheet: some View {
        OptionSelectionView(selectedOption: $viewModel.selectedMilk, title: "What type of milk do you prefer?", options: AllmilkTypes) { milk in
            viewModel.updatePriceForMilk(milk)
        }
    }
    
    private var syrupSheet: some View {
        OptionSelectionView(selectedOption: $viewModel.selectedSyrup, title: "What flavor of syrup do you prefer?", options: AllsyrupTypes) { syrup in
            viewModel.updatePriceForSyrup(syrup)
        }
    }
    
    private var totalAmountNextButton: some View {
        VStack {
            HStack {
                Text("Total Amount")
                Spacer()
                Text("$")
                Text(viewModel.isGiftCoffeeSelected ? "0.0": String(format: "%.2f", viewModel.coffeePrice) )
            }
            .font(.system(size: 20))
            .padding(.horizontal, 30)
            
            NavigationLink(
                destination: MyOrderView(viewModel: viewModel, path: $path, coffee: coffee)
                    .navigationBarBackButtonHidden(true),
                label: {
                    Text("Next")
                        .nextButtonAppearance()
                })
        }
    }
    
    private var ice: some View {
        HStack {
            Text("Ice")
            Spacer()
            CompositionLevelView(level: $viewModel.selectedIceAmount, onImage: Image("cube"), onColor: .cubeColor)
                .onTapGesture(count: 2) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        viewModel.selectedIceAmount = 0
                    }
                }
        }
        .padding()
    }
    
    private var additives: some View {
        NavigationLink(destination: AdditivesView(viewModel: viewModel, path: $path)) {
            HStack {
                Text("Additives")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.black)
            .padding()
        }
    }
    
    private var grinding: some View {
        HStack {
            Text("Grinding")
            Spacer()
            HStack(spacing: 20) {
                Image("smallBean")
                    .renderingMode(.template)
                    .foregroundColor(viewModel.selectedGrindSize == 0 ? .coffeeBeanColor : .gray)
                    .onTapGesture {
                        viewModel.selectedGrindSize = 0
                    }
                
                Image("bigBean")
                    .renderingMode(.template)
                    .foregroundColor(viewModel.selectedGrindSize == 1 ? .coffeeBeanColor : .gray)
                    .onTapGesture {
                        viewModel.selectedGrindSize = 1
                    }
            }
        }
        .padding()
    }
    
    private var syrup: some View {
        HStack {
            Text("Syrup")
            Spacer()
            Button(action: {
                viewModel.isSyrupSelectionTapped = true
            }) {
                Text(viewModel.selectedSyrup.isEmpty ? "Select" : viewModel.selectedSyrup)
            }
            .foregroundStyle(.black)
        }
        .padding()
    }
    
    private var milkType: some View {
        HStack {
            Text("Milk")
            Spacer()
            Button(action: {
                viewModel.isMilkSelectionTapped = true
            }) {
                Text(viewModel.selectedMilk.isEmpty ? "Select" : viewModel.selectedMilk)
            }
            .foregroundStyle(.black)
        }
        .padding()
    }
    
    private var roasting: some View {
        HStack {
            Text("Roasting")
            Spacer()
            CompositionLevelView(level: $viewModel.selectedRoastAmount, onImage: Image("fire"), onColor: .fireColor)
        }
        .padding()
    }
    
    private var coffeeSort: some View {
        NavigationLink(destination: CoffeeCountryView(viewModel: viewModel, path: $path)) {
            HStack {
                Text("Coffee sort")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.black)
            .padding()
        }
    }
    
    
    private var coffeeType: some View {
        HStack(spacing: 15) {
            Text("Coffee type")
            Spacer()
            VStack {
                Slider(value: $viewModel.coffeeType, in: 0...1)
                    .frame(width: 225)
                    .accentColor(.fireColor)
                HStack {
                    Text("Arabica")
                        .foregroundColor(.black.opacity(max(0.3,1 - viewModel.coffeeType)))
                        .animation(.easeIn, value: viewModel.coffeeType)
                    Spacer()
                    Text("Robusta")
                        .foregroundColor(.black.opacity(max(0.3, viewModel.coffeeType)))
                        .animation(.easeIn, value: viewModel.coffeeType)
                    
                }
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
            }
        }
        .padding()
    }
}

#Preview {
    CoffeeAssemblageView(viewModel: OrderViewModel(), path: .constant(NavigationPath()), coffee: .example)
}
