//
//  RewardsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

struct RewardsView: View {
    
    let rewards: [Reward] = [
           Reward(name: "Americano", date: "24 June | 12:30", points: "+ 12 Pts"),
           Reward(name: "Latte", date: "22 June | 08:30", points: "+ 12 Pts"),
           Reward(name: "Raf", date: "16 June | 10:48", points: "+ 12 Pts"),
           Reward(name: "Flat White", date: "12 May | 11:25", points: "+ 12 Pts")
       ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Rewards")
            
            LoyaltyView()
                
            RedeemPointsView()
            HStack {
                Text("History Rewards")
                    .font(.system(size: 20))
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            List(rewards) { reward in
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(reward.name)
                            .font(.system(size: 16))
                        
                        Text(reward.date)
                            .font(.system(size: 12))
                            .padding(.bottom)

                    }
                    Spacer()
                    Text(reward.points)
                        .font(.system(size: 14))

                }
                .listRowSeparator(.visible)
            }
            .scrollContentBackground(.hidden)
        }
        .poppinsFont(size: 24)
    }
}

#Preview {
    RewardsView()
}
