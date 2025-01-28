//
//  TabView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewModel = OrderViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = .lightGrayBackground
    }
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HomePageView(orderViewModel: viewModel)
                .tag(1)
                .tabItem {
                    Image("Home")
                }
            
            RewardsView(orderViewModel: viewModel)
                .tag(2)
                .tabItem {
                    Image("Reward")
                }
            
            Historyview()
                .tag(3)
                .tabItem {
                    Image("History")
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
    
    struct Historyview: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> HistoryViewController {
            HistoryViewController()
        }
        
        func updateUIViewController(_ uiViewController: HistoryViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = HistoryViewController
        
        
        
        
    }
}

#Preview {
    TabBarView()
}

