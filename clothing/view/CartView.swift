import SwiftUI

struct CartView: View {
    @Binding var cartItems: [ClothingItem]

    var body: some View {
        VStack {
            if cartItems.isEmpty {
                emptyCartView
            } else {
                itemsListView
                totalPriceView
            }
            Spacer()
        }
        .navigationTitle("Your Cart")
        .toolbar {
            EditButton()
        }
        .padding()
    }
    
    private var emptyCartView: some View {
        VStack {
            Text("Your cart is empty")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.gray)
            
            Image(systemName: "cart.fill.badge.xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .accessibilityLabel("Empty Cart Icon")
        }
        .padding()
    }
    
    private var itemsListView: some View {
        List {
            ForEach(cartItems) { item in
                CartItemView(item: item)
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
    
    private var totalPriceView: some View {
        HStack {
            Spacer()
            Text("Total: \(calculateTotalPrice())")
                .font(.title)
                .bold()
                .padding()
                .foregroundColor(.blue)
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
    
    private func calculateTotalPrice() -> String {
        let total = cartItems.reduce(0) { currentTotal, item in
            let priceValue = Double(item.price.replacingOccurrences(of: "₱", with: "").replacingOccurrences(of: ",", with: "")) ?? 0.0
            return currentTotal + priceValue
        }
        return formatCurrency(total)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₱"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "₱0.00"
    }
}

struct CartItemView: View {
    var item: ClothingItem
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityLabel("\(item.type) image")
            
            VStack(alignment: .leading) {
                Text(item.type)
                    .font(.headline)
                Text("Price: \(item.price)")
                    .font(.subheadline)
            }
        }
        .onTapGesture {
            // Action on tap if needed
        }
    }
}

#Preview {
    CartView(cartItems: .constant([
        ClothingItem(type: "Hiraya", stocks: 20, price: "₱2,999", imageName: "c1"),
        ClothingItem(type: "Nicole", stocks: 15, price: "₱3,159", imageName: "c2")
    ]))
}
