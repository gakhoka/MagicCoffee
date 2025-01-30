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
    @Binding var path: NavigationPath
    @State private var isPresented = false
    var coffee: Coffee
    
    var body: some View {
        VStack(alignment: .leading) {

        
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
                            HStack {
                                Text(coffee.name)
                                    .font(.system(size: 18))
                                Spacer()
                                HStack(spacing: 0) {
                                    Text("$")
                                    Text(String(format: "%.2f", coffee.price))
                                        .foregroundColor(.black)
                                }
                                .font(.system(size: 16 ))
                            }
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
                                Text(coffee.milk == "" ? "Regular Milk": coffee.milk)
                                
                                Text("|")
                                Text(coffee.syrup == "" ? "No Syrup" : coffee.syrup)
                            }
                            .foregroundStyle(.gray)
                            
                            Text("x\(coffee.count)")
                        }
                        .font(.system(size: 16))
                        
                        Spacer()
                    }
                    .swipeActions {
                        Button {
                            withAnimation(.easeOut(duration: 0.3)) {
                                viewModel.removeOrder(coffee)
                            }
                        } label: {
                            Image("TrashCan")
                        }
                        .tint(.lightRed)
                    }
                }
                .listRowBackground(Color.lightGrayBackground)
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            
            addNewCoffee
                        
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
                    isPresented.toggle()
                } label: {
                    Text("Next")
                        .nextButtonAppearance()
                        .frame(width: UIScreen.main.bounds.width / 2)
                }
            }
            .padding(.horizontal)
            
        }
        .sheet(isPresented: $isPresented, content: {
            PaymentView(viewModel: viewModel, path: $path)
                .presentationDetents([.height(500)])
        })
        
        .onAppear {
            viewModel.fetchUserOrders()
            print(viewModel.userOrderCount)
        }
        .poppinsFont(size: 16)
        .customBackButton {
            dismiss()
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.getFreeCoffee()
                    path = NavigationPath()
                } label: {
                    Text(viewModel.freeCoffees > 0 ? "\(viewModel.freeCoffees)" : "")
                    Image("cupofcoffee")
                        .opacity(viewModel.freeCoffees > 0 ? 1.0 : 0.0)
                }
            }
        }
        .navigationTitle("My order")
    }
    
    private var addNewCoffee: some View {
        HStack {
            Spacer()
            Text("Add new coffee")
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
        .onTapGesture {
            path = NavigationPath()
            viewModel.resetCoffee(coffee: coffee)
        }
    }
}

#Preview {
    MyOrderView(viewModel: OrderViewModel(), path: .constant(NavigationPath()), coffee: .example)
}
