//
//  AsyncImage.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 27.01.25.
//


import SwiftUI

struct AsyncCoffeeView: View {
    
    let image: String
    
    var body: some View {
        if let imageUrl = URL(string: image) {
            AsyncImage(url: imageUrl, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                case .failure:
                    Image("internet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                @unknown default:
                    Image("internet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
            }
        }
    }
}
