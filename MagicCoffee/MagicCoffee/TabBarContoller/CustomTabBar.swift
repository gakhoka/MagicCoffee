//
//  CustomTabBar.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selection: Int
    let tabBarItems = ["Home", "Reward", "History"]
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 80)
                .foregroundStyle(.white)
                .shadow(radius: 5)
            
            HStack(spacing: 40) {
                ForEach(0..<3) { index in
                    Button {
                        selection = index + 1
                    } label: {
                        Image(tabBarItems[index])
                            .foregroundStyle(index + 1 == selection ? Color.black : Color.tabItemColor)
                    }
                    .padding()
                    
                }
            }
            .frame(height: 80)
        }
        .padding(.horizontal, 30)
    }
}
