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
    
    var body: some View {
        NavigationView {
            VStack {
                topView
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    selectYourCoffee
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.coffees, id: \.id) { coffee in
                                NavigationLink(destination: CoffeeOrderView(coffee: coffee)) {
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
                .roundedRectangleStyle(cornerRadius: 20, color: .navyGreen)
                .edgesIgnoringSafeArea(.bottom)
                
            }
        }
    }
    
    private var topView: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 5) {
                Text("Welcome !")
                    .foregroundStyle(.gray)
                Text("Alex")
                    .font(.system(size: 24))
            }
            .poppinsFont(size: 16)
            
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
