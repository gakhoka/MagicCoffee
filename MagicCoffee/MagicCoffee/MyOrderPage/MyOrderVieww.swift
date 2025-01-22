//
//  MyOrderVieww.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 21.01.25.
//

import SwiftUI

struct MyOrderView: View {
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    var coffee: Coffee?

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("My order")
                    .padding()
                Spacer()
                Text("$")
                Text(String(format: "%.2f", viewModel.total))
                    .padding()
            }
            .poppinsFont(size: 24)
            
            List {
                ForEach(viewModel.coffees) { coffee in
                    HStack {
                        if let imageUrl = URL(string: coffee.image) {
                            AsyncImage(url: imageUrl) { image in
                                image.image?.resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(coffee.name)
                                .font(.system(size: 18))
                            HStack {
                                Text(coffee.size.rawValue)
                                Text("|")
                                Text(coffee.grinding.rawValue)
                                Text("|")
                                if coffee.iceAmount > 0 {
                                    Text("iced |")
                                }
                                
                            }
                            .foregroundStyle(.gray)
                            
                            HStack {
                                if coffee.milk  == "" {
                                    Text("regular milk")
                                } else {
                                    Text(coffee.milk ?? "")
                                    Text("milk")
                                }
                                Text("|")
                                Text(coffee.syrup ?? "No syrup")
                            }
                            .foregroundStyle(.gray)
                            
                            Text("x\(coffee.count)")
                        }
                        .font(.system(size: 16))
                        
                        
                        Spacer()
                        
                        VStack {
                            Text("$")
                            HStack(spacing: 0) {
                                
                                Text(String(format: "%.2f", coffee.price))
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                            }
                            Spacer()
                        }
                        .padding(.top)
                    }
                }
                .listRowBackground(Color.lightGrayBackground)
                
            }
            .scrollContentBackground(.hidden)
            
        }
        .poppinsFont(size: 16)
        .customBackButton {
            dismiss()
        }
    }
}

#Preview {
    MyOrderView(viewModel: OrderViewModel())
}
