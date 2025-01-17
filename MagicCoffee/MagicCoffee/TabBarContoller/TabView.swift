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
            HistoryView()
                .tag(3)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(selection: $selection)
        }
    }
    
    struct HistoryView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> HistoryViewController {
            let vc = HistoryViewController()
            return vc
        }
        
        func updateUIViewController(_ uiViewController: HistoryViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = HistoryViewController
        
        
    }
}

#Preview {
    TabBarView()
}

