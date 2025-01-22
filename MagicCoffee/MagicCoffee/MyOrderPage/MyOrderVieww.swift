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
        
            Text("My order")
                .padding()
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
                    .swipeActions {
                        Button {
                            viewModel.removeOrder(coffee)
                        } label: {
                            Image("TrashCan")
                        }
                        .tint(.lightRed)
                    }
                }
                .listRowBackground(Color.lightGrayBackground)
            }
            .scrollContentBackground(.hidden)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Total price")
                        .foregroundStyle(.gray)
                    HStack {
                        Text("$")
                        Text(String(format: "%.2f", viewModel.total))
                            .font(.system(size: 24))
                    }
                }
                .padding(.leading)
                Spacer()
                Button {
                    viewModel.placeOrder()
                } label: {
                    HStack {
                        Image("Cart")
                        Text("Next")
                    }
                }
                .nextButtonAppearance()
                .frame(width: UIScreen.main.bounds.width / 2)

            }
            .padding(.horizontal)
            
        }
        .poppinsFont(size: 16)
        .customBackButton {
            dismiss()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("New")
                        .foregroundColor(Color.navyGreen)
                        .poppinsFont(size: 14)
                    Image(systemName: "cup.and.saucer.fill")
                }

            }
        }
    }
}

#Preview {
    MyOrderView(viewModel: OrderViewModel())
}
