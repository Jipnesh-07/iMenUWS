//
//  UserOrderView.swift
//  iMenUWS
//
//  Created by STUDENT on 20/10/24.
//

import SwiftUI

struct UserOrdersView: View {
    @EnvironmentObject var orderManager: OrderManager // Access to order manager
    @State private var showingAlert = false // State for showing the confirmation alert
    @Environment(\.presentationMode) var presentationMode // To handle redirection after confirmation

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    if orderManager.currentOrder.isEmpty {
                        Text("No orders added.")
                            .font(.headline)
                            .padding()
                    } else {
                        // Display each order item
                        ForEach(orderManager.currentOrder) { orderItem in
                            OrderRow(orderItem: orderItem)
                        }
                        
                        // Display total price and delivery address at the bottom of the orders list
                        VStack(spacing: 10) {
                            HStack {
                                Text("Total Price:")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("$\(String(format: "%.2f", orderManager.totalPrice))")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            
                            // Delivery Address
                            HStack {
                                Text("Delivery Address:")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(orderManager.deliveryAddress) // Assuming deliveryAddress is in orderManager
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .padding(.top, 10)
                        
                        // Confirm Order Button
                        Button(action: {
                            // Show the confirmation alert
                            showingAlert = true
                        }) {
                            HStack {
                                Text("Confirm Order")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$\(String(format: "%.2f", orderManager.totalPrice))")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                        .padding(.top, 20)
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Order Confirmed"),
                                message: Text("Your order has been successfully placed."),
                                dismissButton: .default(Text("OK")) {
                                    // Redirect to the home screen or any other tab
                                    self.presentationMode.wrappedValue.dismiss() // Go back to the previous screen (User Home Screen)
                                }
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("My Orders")
        }
    }
}

struct OrderRow: View {
    var orderItem: OrderItem
    @EnvironmentObject var orderManager: OrderManager // Access to the order manager
    @State private var quantity: Int
    
    init(orderItem: OrderItem) {
        self.orderItem = orderItem
        _quantity = State(initialValue: orderItem.quantity) // Initialize quantity from the orderItem
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top) {
                // Food Image
                Image(orderItem.foodItem.image ?? "bur1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .frame(width: 100, height: 105)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                
                // Food Information
                VStack(alignment: .leading, spacing: 1) {
                    // Food Name
                    Text(orderItem.foodItem.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    // Food Ingredients or Description
                    Text(orderItem.foodItem.ingredients)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Restaurant: #\(orderItem.foodItem.restaurantId)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    HStack {
                        // Quantity Selector
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                                orderManager.updateOrder(item: orderItem, quantity: quantity)
                            }
                        }) {
                            Image(systemName: "minus.square")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        .padding(.trailing, 1)
                        
                        Text("\(quantity)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            quantity += 1
                            orderManager.updateOrder(item: orderItem, quantity: quantity)
                        }) {
                            Image(systemName: "plus.square")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        .padding(.leading, 1)
                        
                        Spacer()
                        
                        // Price
                        Text("$\(String(format: "%.2f", orderItem.foodItem.price * Double(quantity)))")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 18)
                }
                .padding(.leading, 8)
                
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Remove button
            Button(action: {
                orderManager.removeItem(orderItem: orderItem)
            }) {
                Image(systemName: "xmark")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            .padding(8)
            .padding(.top, 4)
        }
    }
}
