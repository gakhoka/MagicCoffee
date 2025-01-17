//
//  CoffeeAssemblageView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CoffeeAssemblageView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = OrderViewModel()
    @State private var sliderValue = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    selectBarista
                    Divider()
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
        }
        .navigationTitle("Coffee Lover Assemblage")
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
    private var milkSheet: some View {
        OptionSelectionView(selectedOption: $viewModel.selectedMilk, title: "What type of milk do you prefer?", options: viewModel.milkTypes)
    }
    
    private var syrupSheet: some View {
        OptionSelectionView(selectedOption: $viewModel.selectedSyrup, title: "What flavor of syrup do you prefer?", options: viewModel.syrupTypes)
    }
    
    private var totalAmountNextButton: some View {
        VStack {
            HStack {
                Text("Total Amount")
                Spacer()
                Text("EUR 6.86")
            }
            .font(.system(size: 20))
            .padding(.horizontal, 30)
            Button(action: {
               //todo
            }) {
                Text("Next")
            }
            .nextButtonAppearance()
        }
    }
    
    private var ice: some View {
        HStack {
            Text("Ice")
                .foregroundStyle(.gray)
            Spacer()
            ForEach(0..<3) { index in
                iceAmountView(amount: index)
            }
        }
        .padding()
    }
    
    private var additives: some View {
        NavigationLink(destination: Text("Additives")) {
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
            HStack(spacing: 20) {
                ForEach(0..<3) { index in
                    roastingAmountView(amount: index)
                }
            }
        }
        .padding()
    }
    
    private var coffeeSort: some View {
        NavigationLink(destination: Text("Coffee sorting")) {
            HStack {
                Text("Coffee sort")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.black)
            .padding()
        }
    }
    
    private var selectBarista: some View {
        NavigationLink(destination: Text("Barista Selection")) {
            HStack {
                Text("Select a barista")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
    
    private var coffeeType: some View {
        HStack(spacing: 15) {
            Text("Coffee type")
            Spacer()
            VStack {
                Slider(value: $viewModel.value, in: 0...1)
                    .frame(width: 225)
                    .accentColor(.fireColor)
                HStack {
                    Text("Arabica")
                        .foregroundColor(.black.opacity(max(0.3,1 - viewModel.value)))
                        .animation(.easeIn, value: viewModel.value)
                    Spacer()
                    Text("Robusta")
                        .foregroundColor(.black.opacity(max(0.3, viewModel.value)))
                        .animation(.easeIn, value: viewModel.value)

                }
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
            }
        }
        .padding()
    }
    
    func iceAmountView(amount: Int) -> some View {
        Button(action: { viewModel.selectedIceAmount = amount }) {
            HStack(spacing: 2) {
                ForEach(0..<amount + 1, id: \.self) { _ in
                    Image("Ice")
                }
            }
            .foregroundColor(viewModel.selectedIceAmount == amount ? .black : .gray)
        }
    }
    
    func roastingAmountView(amount: Int) -> some View {
        Button(action: { viewModel.selectedRoastAmount = amount }) {
            HStack(spacing: 2) {
                ForEach(0..<amount + 1, id: \.self) { _ in
                    Image("fire")
                }
            }
            .foregroundColor(viewModel.selectedRoastAmount == amount ? .fireColor : .gray)
        }
    }
}

#Preview {
    CoffeeAssemblageView()
}
