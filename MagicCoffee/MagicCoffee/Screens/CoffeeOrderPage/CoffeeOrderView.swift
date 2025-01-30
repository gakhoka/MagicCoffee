//
//  CoffeeOrderView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CoffeeOrderView: View {
    
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss: DismissAction
    @Binding var path: NavigationPath

    var coffee: Coffee
    
    var body: some View {
        VStack {
            coffeeImage
            ScrollView {
                if !viewModel.isGiftCoffeeSelected {
                    coffeeAmount
                }
                onsiteOrTakeAway
                cupSize
                ristretto
                timePicker
                totalAmount
                NavigationLink(destination: CoffeeAssemblageView(viewModel: viewModel, path: $path, coffee: coffee)) {
                    coffeeLoverAssemblage
                }
            }
        }
        .poppinsFont(size: 16)
        .onAppear(perform: resetCoffee)
        .onAppear(perform: viewModel.fetchUserOrders)
        .navigationTitle("Order")
        .customBackButton { dismiss() }
    }
    
    func resetCoffee() {
        if viewModel.coffeeName != coffee.name {
            viewModel.coffeeName = coffee.name
            viewModel.coffeePrice = coffee.price
            viewModel.coffeeCount = 1
            viewModel.volumeSize = 1
            viewModel.ristrettoSize = 1
            viewModel.coffeeImage = coffee.image
        }
    }
    
    
    private var cupSize: some View {
        HStack {
            Text("Cup size")
                .padding()
            Spacer()
            HStack(alignment: .bottom, spacing: 30) {
                
                ForEach(viewModel.cupData.keys.sorted(by: >), id: \.self) { key in
                    VStack {
                        Image(key)
                            .foregroundColor(
                                viewModel.volumeSize == (viewModel.cupData[key] ?? 1) ? .black : .gray)
                            .onTapGesture {
                                viewModel.updatePriceForSize(newSize: viewModel.cupData[key] ?? 1)
                            }
                        
                        Text("\(viewModel.cupData[key] == 1 ? 250 : (viewModel.cupData[key] == 2 ? 350 : (viewModel.cupData[key] == 3 ? 450 : 0)))ml")
                            .foregroundStyle(viewModel.volumeSize == (viewModel.cupData[key] ?? 1) ? .black : .gray)
                            .font(.system(size: 12))
                    }
                }
            }
            .foregroundStyle(.gray)
        }
        .padding()

    }

    private var onsiteOrTakeAway: some View {
        HStack {
            Text("Onsite / TakeAway")
                .padding()
            Spacer()
            HStack(spacing: 20) {
                Image("OnsiteImage")
                    .foregroundStyle(viewModel.isTakeAway ? .gray : .black)
                    .onTapGesture {
                        viewModel.isTakeAway.toggle()
                    }
                Image("TakeAwayImage")
                    .foregroundStyle(viewModel.isTakeAway ? .black : .gray)
                    .onTapGesture {
                        viewModel.isTakeAway.toggle()
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var ristretto: some View {
        HStack {
            Text("Ristretto")
                .padding()
            Spacer()
            HStack {
                Text("Single")
                    .capsuleButton()
                    .foregroundStyle(viewModel.ristrettoSize == 1 ? .black : .gray)
                    .onTapGesture {
                        viewModel.updateRistrettoOption(option: 1)
                    }
                
                Text("Double")
                    .capsuleButton()
                    .foregroundStyle(viewModel.ristrettoSize == 2 ? .black : .gray)
                    .onTapGesture {
                        viewModel.updateRistrettoOption(option: 2)
                    }
            }
        }
        .padding(.horizontal)
    }
    
    private var coffeeAmount: some View {
        HStack {
            Text(coffee.name)
                .padding()
            Spacer()
            HStack {
                Button(action: {
                    if viewModel.coffeeCount > 1 {
                        viewModel.coffeeCount -= 1
                        viewModel.coffeePrice = viewModel.coffeePrice - coffee.price

                    }
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.black)
                }
                
                Text("\(viewModel.coffeeCount)")
                    .font(.title3)
                    .foregroundColor(.black)
                
                Button(action: {
                    viewModel.coffeeCount += 1
                    viewModel.coffeePrice = viewModel.coffeePrice + coffee.price
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
            }
            .capsuleButton()
        }
        .padding(.horizontal)
    }
    
    private var totalAmount: some View {
        HStack {
            Text("Total Amount")
                .padding(.horizontal)
            
            Spacer()
            Text("$")
            Text(viewModel.isGiftCoffeeSelected ? "0.0": String(format: "%.2f", viewModel.coffeePrice) )
        }
        .font(.system(size: 20))
        .padding()
    }
    
    private var timePicker: some View {
        
        HStack {
            Image("timeClock")
                .padding(.leading)
                
            DatePicker("", selection: $viewModel.pickDate, in: Date()...,  displayedComponents: [.hourAndMinute , .date])
                .opacity(viewModel.isDatePickerOn ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: viewModel.isDatePickerOn)
                .padding(.leading)
            
            Toggle("", isOn: $viewModel.isDatePickerOn)
        }
        .padding()
    }
    
    private var coffeeLoverAssemblage: some View {
        HStack {
            Text("Coffee lover assemblage")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(
            LinearGradient(colors: [.creamColor, .brownColor], startPoint: .leading, endPoint: .trailing)
                .cornerRadius(20)
        )
        .cornerRadius(20)
        .padding()
    }
    
    private var coffeeImage: some View {
        VStack {
            if let imageUrl = URL(string: coffee.image) {
                AsyncImage(url: imageUrl) { image in
                    image.image?.resizable()
                        .scaledToFit()
                }
            
                .frame(width: 200, height: 200)
                .roundedRectangleStyle(color: Color.navyGreen)
                .padding()
                .frame(width: UIScreen.main.bounds.width, height: 200)         
            }
        }
    }
}

#Preview {
    CoffeeOrderView(viewModel: OrderViewModel(), path: .constant(NavigationPath()), coffee: .example)
}

