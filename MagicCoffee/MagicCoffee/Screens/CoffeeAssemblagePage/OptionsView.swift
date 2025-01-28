//
//  OptionSelectionView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct OptionSelectionView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedOption: String
    
    let title: String
    let options: [String]
    var onSelect: ((String) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text(title)
                .foregroundColor(.gray)
                .padding(.top)
            
            VStack(spacing: 5) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                        onSelect?(option)
                        dismiss()
                    }) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                    }
                    
                    Divider()
                }
            }
            .background(Color.clear)
            .cornerRadius(12)
            .padding(.horizontal)
            
            cancelButton
        }
        .poppinsFont(size: 16)
        .presentationDetents([
            .height(400)
        ])
    }
    
    private var cancelButton: some View {
        Button(action: {
            dismiss()
        }) {
            Text("Cancel")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.black)
                .font(.system(size: 16, weight: .heavy))
        }
        .padding()
    }
}

