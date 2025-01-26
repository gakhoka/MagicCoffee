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
    @State private var text = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                topView
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    selectYourCoffee
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.coffees.filter { coffee in
                                text.isEmpty || coffee.name.localizedCaseInsensitiveContains(text)
                            }, id: \.id) { coffee in
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
                        .padding(.bottom, 120)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal)
                }
                .onAppear {
                    viewModel.fetchUser()
                    orderViewModel.fetchUserOrders()
                    print(viewModel.username)
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
                    .poppinsFont(size: 16)
                Text(viewModel.username)
                    .poppinsFont(size: 20)
            }
            Spacer()

            Spacer()
            TextField("Search coffee...", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
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
