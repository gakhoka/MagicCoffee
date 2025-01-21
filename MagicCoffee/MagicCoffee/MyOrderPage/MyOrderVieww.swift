//
//  MyOrderVieww.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 21.01.25.
//

import SwiftUI

struct MyOrderVieww: View {
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
          
                Text("My order")
                .font(.system(size: 24))
                .padding()
            
            
            List {
                ForEach(viewModel.coffees) { coffee in
                    HStack {
                        Image("coffee1")
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
                                Text(coffee.milk ?? "Regular milk")
                                Text("|")
                                Text(coffee.syrup ?? "No syrup")
                            }
                            .foregroundStyle(.gray)
                           
                            Text("x\(coffee.count)")
                        }
                        .font(.system(size: 16))

                        
                        Spacer()
                        
                        VStack {
                            Text("$ \(coffee.price)")
                        }
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
    MyOrderVieww(viewModel: OrderViewModel())
}
