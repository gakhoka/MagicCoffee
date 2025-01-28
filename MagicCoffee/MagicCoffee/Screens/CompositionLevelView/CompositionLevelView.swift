//
//  CompositionLevelView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 22.01.25.
//

import SwiftUI

struct CompositionLevelView: View {
    
    @Binding var level: Int
    var onImage: Image
    var onColor: Color
    var maximumLevel = 3
    var offimage: Image?
    var offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1..<maximumLevel + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(level > 0 && number <= level ? onColor : offColor)
                    .onTapGesture {
                        level = number
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if level > 0 && number <= level {
            return onImage
        } else {
            return offimage ?? onImage
        }
    }
}

#Preview {
    CompositionLevelView(level: .constant(2), onImage: Image("Fire"), onColor: .gray)
}
