//
//  TabView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HomePageView()
                .tag(1)
                .tabItem {
                    Image("Home")
                }
            
            RewardsView()
                .tag(2)
                .tabItem {
                    Image("Reward")
                }
            ProfilePageView()
                .tag(3)
                .tabItem {
                    Image("Profile")
                }
        }
        .accentColor(.black)
    }
    
    struct ProfilePageView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> ProfilePageViewController {
            let vc = ProfilePageViewController()
            return vc
        }
        
        func updateUIViewController(_ uiViewController: ProfilePageViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = ProfilePageViewController
    }
}

#Preview {
    TabBarView()
}

