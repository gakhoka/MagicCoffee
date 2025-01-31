//
//  TabView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject var viewModel = OrderViewModel()
    @State private var selection = 1

    init() {
        UITabBar.appearance().backgroundColor = .lightGrayBackground
    }
        
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
        }
        .accentColor(.black)
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

