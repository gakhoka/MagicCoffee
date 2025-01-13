//
//  HomePageView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct HomePageView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    let coffeeImages = ["coffee1","coffee2","coffee3","coffee5", "latte2", "coffee4"]
    
    var body: some View {
        VStack {
            topView
                .padding()
            
            VStack(alignment: .leading) {
                
                selectYourCoffee
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(coffeeImages, id: \.self) { image in
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(width: 175)
                                
                                VStack {
                                    Image(image)
                                    Text(image)
                                }
                                .frame(height: 150)
                                .padding()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.horizontal)
                
            }
        
            .roundedRectangleStyle(width: .infinity, height: .infinity, cornerRadius: 20, color: .navyGreen)
            .edgesIgnoringSafeArea(.bottom)
            
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
