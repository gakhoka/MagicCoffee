//
//  OrderDetailsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI

struct OrderDetailsView: View {
    
    var coffee: Coffee
    let cupData: [String: Int] = [
           "smallCup": 250,
           "mediumCup": 350,
           "largeCup": 450
       ]

    @State private var count = 1
    
    var body: some View {
        VStack {
            coffeeAmount
            Divider()
            ristretto
            Divider()
            onsiteOrTakeAway
            Divider()
            volume
            Divider()
        }
    }
    
    
    private var volume: some View {
        HStack {
            Text("Volume, ml")
                .padding()
            Spacer()
            HStack(alignment: .bottom, spacing: 30) {

                ForEach(cupData.keys.sorted(by: >), id: \.self) { key in
                    VStack {
                        Image(key)
                        Text("\(cupData[key] ?? 0)")
                            .font(.headline)
                    }
                }
            }
            .foregroundStyle(.gray)
        }
        .padding()

    }
    
    private var onsiteOrTakeAway: some View {
        HStack {
            Text("Onsitt / TakeAway")
                .padding()
            Spacer()
            HStack(spacing: 20) {
                Image("OnsiteImage")
                    .foregroundStyle(.gray)
                Image("TakeAwayImage")
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal)
    }
    
    private var ristretto: some View {
        HStack {
            Text("Ristretto")
                .padding()
            Spacer()
            HStack {
                Button("One") {
                    
                }
                .capsuleButton()
                
                Button("Two") {
                    
                }
                .capsuleButton()
                
            }
        }
        .padding(.horizontal)
    }
    

    
    private var coffeeAmount: some View {
        HStack {
            Text(coffee.name)
                .padding()
            Spacer()
            HStack {
                Button(action: {
                    if count > 0 {
                        count -= 1
                    }
                }) {
                    Image(systemName: "minus")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Text("\(count)")
                    .font(.title3)
                    .foregroundColor(.black)
                
                Button(action: {
                    count += 1
                }) {
                    Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.black)

                }
            }
            .capsuleButton()
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    OrderDetailsView(coffee: .example)
}
