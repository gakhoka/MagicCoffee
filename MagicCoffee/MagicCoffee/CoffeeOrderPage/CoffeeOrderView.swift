//
//  CoffeeOrderView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CoffeeOrderView: View {
    
    @StateObject var viewModel = OrderViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var coffee: Coffee
    
    var body: some View {
        NavigationView {
            VStack {
                coffeeImage
                ScrollView {
                    coffeeAmount
                    onsiteOrTakeAway
                    volume
                    ristretto
                    timePicker
                    NavigationLink(destination: CoffeeAssemblageView()) {
                        coffeeLoverAssemblage
                    }
                    nextButton
                }
            }
            .poppinsFont(size: 16)
        }
        .onAppear {
            viewModel.coffeeName = coffee.name
        }
        .navigationTitle("Order")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    private var volume: some View {
        HStack {
            Text("Volume, ml")
                .padding()
            Spacer()
            HStack(alignment: .bottom, spacing: 30) {
                
                ForEach(viewModel.cupData.keys.sorted(by: >), id: \.self) { key in
                    VStack {
                        Image(key)
                            .foregroundColor(
                                viewModel.volumeSize == (viewModel.cupData[key] ?? 1) ? .black : .gray)
                            .onTapGesture {
                                viewModel.volumeSize = viewModel.cupData[key] ?? 1
                            }
                        Text("\(viewModel.cupData[key] ?? 0)")
                            .font(.headline)
                            .foregroundStyle(viewModel.volumeSize == (viewModel.cupData[key] ?? 1) ? .black : .gray)
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
                Text("One")
                    .capsuleButton()
                    .foregroundStyle(viewModel.ristrettoSize == 1  ? .black : .gray)
                .onTapGesture {
                    viewModel.ristrettoSize = 1
                }
                    
                
                Text("Two")
                    .capsuleButton()
                    .foregroundStyle(viewModel.ristrettoSize == 1  ? .gray : .black)
                .onTapGesture {
                    viewModel.ristrettoSize = 2
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
                    if viewModel.coffeeCount > 0 {
                        viewModel.coffeeCount -= 1
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
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)

                }
                
            }
            .capsuleButton()
            
        }
        .padding(.horizontal)
    }
    
    private var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        })  {
            Image(systemName: "arrow.left")
                .foregroundStyle(.black)
        }
    }
    
    private var nextButton: some View {
        VStack {
            HStack {
                Text("Total Amount")
                    .padding(.horizontal)
                    
                Spacer()
                Text("EUR 6.86")
            }
            .font(.system(size: 20))
            .padding(.horizontal)
            Button(action: {
                
            }) {
                Text("Next")
            }
            .nextButtonAppearance()
        }
    }
    
    private var timePicker: some View {
        HStack() {
            Text("Prepare by a certain time today?")
                .padding()
            VStack {
                Toggle(isOn: $viewModel.isOn) {
                    
                }
                .frame(width: 60)
            }
        }
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
    CoffeeOrderView(coffee: .example)
}

