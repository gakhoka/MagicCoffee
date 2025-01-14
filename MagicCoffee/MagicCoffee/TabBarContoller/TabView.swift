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
            HomePageView()
                .tag(1)
            RewardsView()
                .tag(2)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(selection: $selection)
        }
    }
}

#Preview {
    TabBarView()
}

