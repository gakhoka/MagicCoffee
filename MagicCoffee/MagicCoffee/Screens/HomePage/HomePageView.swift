//
//  HomePageView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject var viewModel = HomePageViewModel()
    @ObservedObject var orderViewModel: OrderViewModel
    @State private var path = NavigationPath()
    @State private var text = ""
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                topView
                    .padding()
                
                VStack {
                    HStack {
                        selectYourCoffee
                        Spacer()
                        freeCoffee
                    }
                    coffeesList
                }
                .onAppear {
                    viewModel.fetchUser()
                   // orderViewModel.resetCoffee(coffee: .example)
                    viewModel.fetchCoffees()
                }
                .roundedRectangleStyle(cornerRadius: 20, color: .navyGreen)
                .edgesIgnoringSafeArea(.bottom)
                .navigationDestination(for: Coffee.self) { coffee in
                    CoffeeOrderView(viewModel: orderViewModel, path: $path, coffee: coffee)
                }
            }
        }
    }
    
    private var freeCoffee: some View {
        Text(orderViewModel.isGiftCoffeeSelected ? "Free coffee" : "")
            .poppinsFont(size: 20)
            .foregroundColor(.creamColor)
            .padding()
    }
    
    private var coffeesList: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.coffees.filter { coffee in
                    text.isEmpty || coffee.name.localizedCaseInsensitiveContains(text)
                }, id: \.id) { coffee in
                    NavigationLink(value: coffee) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.white)
                                .frame(width: 175)
                            VStack {
                                AsyncCoffeeView(image: coffee.image)
                                Text(coffee.name)
                                    .foregroundStyle(.black)
                            }
                            .frame(height: 150)
                            .padding()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 120)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
    }
    
    private var topView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Welcome !")
                    .foregroundStyle(.gray)
                    .poppinsFont(size: 16)
                Text(viewModel.username)
                    .poppinsFont(size: 20)
            }
            Spacer()
            
            Spacer()
            TextField("Search coffee...", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .frame(width: 200)
            
            Spacer()
            NavigationLink {
                ProfilePageView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Image(systemName: "person")
                    .imageScale(.large)
            }

        }
    }
    
    private var selectYourCoffee: some View {
        Text("Select your coffee")
            .poppinsFont(size: 20)
            .foregroundStyle(.white)
            .padding()
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
    HomePageView(orderViewModel: OrderViewModel())
}
