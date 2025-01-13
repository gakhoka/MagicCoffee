//
//  TabView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            Text("1")
                .tag(1)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(selection: $selection)
        }
    }
}

#Preview {
    TabBarView()
}

