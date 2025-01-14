//
//  TabView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().shadowImage = UIImage()
            UITabBar.appearance().isTranslucent = true
            UITabBar.appearance().barTintColor = .clear
            UITabBar.appearance().backgroundColor = UIColor.clear
        }
    
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

