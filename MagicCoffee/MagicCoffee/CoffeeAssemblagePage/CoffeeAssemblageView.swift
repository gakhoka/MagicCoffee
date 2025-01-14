//
//  CoffeeAssemblageView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CoffeeAssemblageView: View {
    
    @State private var selectedGrindSize =  0
    @State private var selectedRoastAmount = 1
    @State private var selectedIceAmount = 1
    @State private var isGrindingSelected = false
    @State private var value = 0.5
    @State private var selectedMilk = ""
    @State private var selectedSyrup = ""
    @State private var isMilkSelectionTapped = false
    @State private var isSyrupSelectionTapped = false
    @State private var milkTypes = ["None", "Cow's", "Lactose-free", "Skimmed", "Vegetable"]
    @State private var syrupTypes = ["None", "Amaretto", "Coconut", "Vanilla", "Caramel"]
    
   
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
            .sheet(isPresented: $isMilkSelectionTapped) {
                milkSheet
            }
            .sheet(isPresented: $isSyrupSelectionTapped) {
                syrupSheet
            }
        }
    }
    
    private var milkSheet: some View {
        OptionSelectionView(selectedOption: $selectedMilk, title: "What type of milk do you prefer?", options: milkTypes)
    }
    
    private var syrupSheet: some View {
        OptionSelectionView(selectedOption: $selectedSyrup, title: "What flavor of syrup do you prefer?", options: syrupTypes)
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
                    .foregroundColor(selectedGrindSize == 0 ? .black : .gray)
                    .onTapGesture {
                        selectedGrindSize = 0
                    }
                
                Image("bigBean")
                    .renderingMode(.template)
                    .foregroundColor(selectedGrindSize == 1 ? .black : .gray)
                    .onTapGesture {
                        selectedGrindSize = 1
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
                isSyrupSelectionTapped = true
            }) {
                Text(selectedSyrup.isEmpty ? "Select" : selectedSyrup)
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
                isMilkSelectionTapped = true
            }) {
                Text(selectedMilk.isEmpty ? "Select" : selectedMilk)
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
                Slider(value: $value, in: 0...1)
                    .frame(width: 225)
                HStack {
                    Text("Arabica")
                    Spacer()
                    Text("Robusta")
                }
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
            }
        }
        .padding()
    }
    
    func iceAmountView(amount: Int) -> some View {
        Button(action: { selectedIceAmount = amount }) {
            HStack(spacing: 2) {
                ForEach(0..<amount + 1, id: \.self) { _ in
                    Image("Ice")
                }
            }
            .foregroundColor(selectedIceAmount == amount ? .black : .gray)
        }
    }
    
    func roastingAmountView(amount: Int) -> some View {
        Button(action: { selectedRoastAmount = amount }) {
            HStack(spacing: 2) {
                ForEach(0..<amount + 1, id: \.self) { _ in
                    Image("fire")
                }
            }
            .foregroundColor(selectedRoastAmount == amount ? .black : .gray)
        }
    }
}

#Preview {
    CoffeeAssemblageView()
}
