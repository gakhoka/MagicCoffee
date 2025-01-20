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
                        toggleSelection(of: additive)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .poppinsFont(size: 16)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundStyle(.black)
        }

    }

    private func toggleSelection(of additive: String) {
        if viewModel.selectedAdditives.contains(additive) {
            viewModel.selectedAdditives.removeAll { $0 == additive }
        } else {
            viewModel.selectedAdditives.append(additive)
        }
    }
}

#Preview {
    AdditivesView()
}
