//
//  CompositionLevelView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 22.01.25.
//

import SwiftUI

struct CompositionLevelView: View {
    
    @Binding var rating: Int
    var onImage: Image
    var onColor: Color
    var maximumLevel = 3
    var offimage: Image?
    var offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1..<maximumLevel + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offimage ?? onImage 
        } else {
            return onImage
        }
    }
}

#Preview {
    CompositionLevelView(rating: .constant(2), onImage: Image("Fire"), onColor: .gray)
}
