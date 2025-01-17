//
//  CoffeeOrderView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CoffeeOrderView: View {
 
    @State var isOn = false
    
    var body: some View {
        NavigationView {
            VStack {
                coffeeImage
                ScrollView {
                    OrderDetailsView()
                    timePicker
                    coffeeLoverAssemblage
                    nextButton
                }
            }
            .poppinsFont(size: 16)
            
        }
        .navigationTitle("Order")
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
                Toggle(isOn: $isOn) {
                    
                }
                .frame(width: 60)
            }
        }
    }
    
    private var coffeeLoverAssemblage: some View {
        HStack {
            Button(action: {
             // TODO: ACTION
            }) {
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
        }
    }
    
    private var coffeeImage: some View {
        Image("coffee3")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .roundedRectangleStyle(color: Color.navyGreen)
            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
            .frame(minHeight: 0, maxHeight:UIScreen.main.bounds.height)
            .padding()
        
    }
 
}

#Preview {
    CoffeeOrderView()
}
