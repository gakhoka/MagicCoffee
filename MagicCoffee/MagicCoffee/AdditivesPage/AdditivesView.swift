//
//  AdditivesView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//


import SwiftUI

struct AdditivesView: View {
    
    @ObservedObject private var viewModel = OrderViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            HStack {
                Text("Select additives")
                Spacer()
            }
            .padding(.horizontal, 50)
            
            List {
                ForEach(viewModel.additives, id: \.self) { additive in
                    HStack {
                        Text(additive)
                            .foregroundColor(viewModel.selectedAdditives.contains(additive) ? .brown : .black)
                            .scaleEffect(viewModel.selectedAdditives.contains(additive) ? 1.1 : 1)
                            .animation(.easeInOut(duration: 0.4), value: viewModel.selectedAdditives.contains(additive))
                        Spacer()
                        if viewModel.selectedAdditives.contains(additive) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.brownColor)
                                .imageScale(.large)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.nardoGray)
                                .imageScale(.large)
                            
                        }
                    }
                    .contentShape(Rectangle())
                    .padding(6)
                    .onTapGesture {
                        viewModel.toggleAdditiveSelection(additive)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .poppinsFont(size: 16)
        .navigationTitle("Select Additives")
        .customBackButton { dismiss() }
    }
}

#Preview {
    AdditivesView()
}
