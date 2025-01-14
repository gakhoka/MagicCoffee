//
//  AdditivesView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

struct AdditivesView: View {
    
    let additives = ["Ceylon cinnamon", "Grated chocolate", "Liquid chocolate", "Marshmallow", "Whipped cream", "Cream", "Nutmeg", "Ice cream"]
    
    @State private var selectedAdditives: [String] = []
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            HStack {
                Text("Select additives")
                Spacer()
            }
            .padding(.horizontal, 50)
            
            List {
                ForEach(additives, id: \.self) { additive in
                    HStack {
                        Text(additive)
                            .foregroundColor(selectedAdditives.contains(additive) ? .brown : .black)
                            .scaleEffect(selectedAdditives.contains(additive) ? 1.1 : 1)
                            .animation(.easeInOut(duration: 0.4), value: selectedAdditives.contains(additive))
                        Spacer()
                        if selectedAdditives.contains(additive) {
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
    }

    private func toggleSelection(of additive: String) {
        if selectedAdditives.contains(additive) {
            selectedAdditives.removeAll { $0 == additive }
        } else {
            selectedAdditives.append(additive)
        }
    }
}

#Preview {
    AdditivesView()
}


