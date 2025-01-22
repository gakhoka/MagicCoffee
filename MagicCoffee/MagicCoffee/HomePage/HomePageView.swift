//
//  HomePageView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct HomePageView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)

    @StateObject var viewModel = HomePageViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                topView
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    selectYourCoffee
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.coffees, id: \.id) { coffee in
                                NavigationLink(value: coffee) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(.white)
                                            .frame(width: 175)
                                        VStack {
                                            if let imageUrl = URL(string: coffee.image) {
                                                AsyncImage(url: imageUrl) { image in
                                                    image.image?.resizable()
                                                        .scaledToFit()
                                                }
                                            }
                                            Text(coffee.name)
                                                .foregroundStyle(.black)
                                        }
                                        .frame(height: 150)
                                        .padding()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .onAppear {
                    print("\(viewModel.username)")

                }
                
                .roundedRectangleStyle(cornerRadius: 20, color: .navyGreen)
                .edgesIgnoringSafeArea(.bottom)
                .navigationDestination(for: Coffee.self) { coffee in
                    CoffeeOrderView(viewModel: orderViewModel, path: $path, coffee: coffee)
                }
            }
        }
    }
    
    private var topView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Welcome !")
                    .foregroundStyle(.gray)
                    .poppinsFont(size: 12)
                Text(viewModel.username)
                    .poppinsFont(size: 16)

            }
            
            Spacer()
            
            HStack(spacing: 20){
                Image("Cart")
                Image("Profile")
            }
            .padding(.horizontal)
        }
    }
    
    private var selectYourCoffee: some View {
        Text("Select your coffee")
            .poppinsFont(size: 20)
            .foregroundStyle(.white)
            .padding()
    }
}

#Preview {
    HomePageView()
}
