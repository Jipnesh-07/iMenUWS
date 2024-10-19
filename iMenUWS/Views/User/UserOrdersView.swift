//
//  UserOrdersView.swift
//  iMenUWS
//
//  Created by STUDENT on 19/10/24.
//

import SwiftUI

struct UserOrdersView: View {
    // Sample user orders (replace with real data from your model or backend)
        var orders: [Order] = sampleOrders // Use the sampleOrders array defined earlier
        
        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(orders) { order in
                            OrderRow(order: order)
                        }
                    }
                    .padding()
                }
                .navigationTitle("My Orders")
            }
        }
}


struct OrderRow: View {
    var order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Display restaurant name (replace with actual restaurant data)
            Text("Restaurant #\(order.restaurantId)")
                .font(.headline)
            
            // Display each food item in the order
            ForEach(order.foodItems) { item in
                HStack(alignment: .top) {
                    // Display food item image
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        // Food item name
                        Text(item.name)
                            .font(.headline)
                        
                        // Food item description (optional)
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                        
                        // Food item price
                        Text("$\(String(format: "%.2f", item.price))")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                }
                .padding(.vertical, 5)
            }

            // Total price
            HStack {
                Text("Total:")
                    .fontWeight(.bold)
                Spacer()
                Text("$\(String(format: "%.2f", order.totalPrice))")
                    .fontWeight(.bold)
            }

            // Address
            Text("Delivery Address: \(order.address)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}


#Preview {
    UserOrdersView()
}
