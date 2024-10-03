import SwiftUI

// Detailed view for each clothing item
struct ClothingDetailView: View {
    var item: ClothingItem
    @Binding var cartItems: [ClothingItem]
    @State private var addedToCart = false
    @State private var quantity = 1
    @State private var showAlert = false
    @State private var showConfirmationDialog = false
    @State private var navigateToCart = false

    var body: some View {
        VStack(spacing: 25) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(12.0)
                .frame(width: 400, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding(.top, 10)

            
            Text(item.type)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.brown)

            
            Text("Price: \(item.price)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.brown)

            
            Text("Available Stocks: \(item.stocks)")
                .font(.subheadline)
                .foregroundColor(.gray)

          
            Stepper(value: $quantity, in: 1...item.stocks) {
                Text("Quantity: \(quantity)")
                    .font(.headline)
                    .foregroundColor(.brown)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)

  
            Text("Total Price: \(calculateTotalPrice())")
                .font(.headline)
                .foregroundColor(.black)

        
            if item.stocks > 0 {
                Button(action: {
                    showConfirmationDialog = true
                }) {
                    Text(addedToCart ? "Added \(quantity) to Cart" : "Add to Cart")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .fontWeight(.bold)
                        .background(addedToCart ? Color.brown: Color(red: 0.847, green: 0.824, blue: 0.761)) // Color D8D2C2
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: addedToCart ? .brown.opacity(0.2) : Color(red: 0.847, green: 0.824, blue: 0.761).opacity(0.5), radius: 8, x: 0, y: 4)
                        .animation(.easeInOut)
                }
            } else {
                Text("Out of Stock")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .padding()
       
        .navigationTitle(item.type)
        .confirmationDialog("Add \(quantity) item(s) to the cart?", isPresented: $showConfirmationDialog) {
            Button("Confirm", role: .destructive) {
                addToCart() // Add to cart and then show alert
                navigateToCart = true
            }
            Button("Cancel", role: .cancel) { }
        }
        .background(
            NavigationLink(destination: CartView(cartItems: $cartItems), isActive: $navigateToCart) {
                EmptyView()
            }
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Added to Cart"),
                message: Text("\(quantity) \(item.type) added to your cart."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func addToCart() {
        for _ in 0..<quantity {
            cartItems.append(item)
        }
        addedToCart = true
        showAlert = true // Trigger the alert
    }

    private func calculateTotalPrice() -> String {
        if let priceValue = Double(item.price.replacingOccurrences(of: "₱", with: "")) {
            let total = priceValue * Double(quantity)
            return String(format: "₱%.2f", total)
        }
        return item.price
    }
}

struct ClothingDetailView_Previews: PreviewProvider {
    @State static var sampleCart = [ClothingItem]()
    
    static var previews: some View {
        ClothingDetailView(
            item: ClothingItem(type: "Hiraya", stocks: 20, price: "₱299", imageName: "c1"),
            cartItems: $sampleCart
        )
    }
}

