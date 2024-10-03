import SwiftUI

struct ContentView: View {
    @State private var clothingItems = [
        ClothingItem(type: "Hiraya", stocks: 20, price: "₱2,999", imageName: "c1"),
        ClothingItem(type: "Nicole", stocks: 15, price: "₱3,159", imageName: "c2"),
        ClothingItem(type: "Alisha", stocks: 10, price: "₱1,250", imageName: "c3"),
        ClothingItem(type: "Angel", stocks: 12, price: "₱1,440", imageName: "c4"),
        ClothingItem(type: "Sarah", stocks: 5, price: "₱1,320", imageName: "c5"),
        ClothingItem(type: "Ella", stocks: 8, price: "₱1,280", imageName: "c6"),
        ClothingItem(type: "Grechelle", stocks: 50, price: "₱1,299", imageName: "c7"),
        ClothingItem(type: "Taylor", stocks: 22, price: "₱1,350", imageName: "c8")
    ]
    
    @State private var cartItems: [ClothingItem] = []
    @State private var searchQuery = ""
    @State private var favoriteItems: [UUID: Bool] = [:]

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var filteredItems: [ClothingItem] {
        if searchQuery.isEmpty {
            return clothingItems
        } else {
            return clothingItems.filter { $0.type.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Banner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .cornerRadius(9.0)
                    .padding(.bottom, 10)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredItems) { item in
                            VStack {
                                ZStack(alignment: .topTrailing) {
                                    NavigationLink(destination: ClothingDetailView(item: item, cartItems: $cartItems)) {
                                        Image(item.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 180)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .contextMenu {
                                                Button(action: {
                                                    toggleFavorite(for: item)
                                                }) {
                                                    Label(isFavorite(item) ? "Remove from Favorites" : "Add to Favorites", systemImage: isFavorite(item) ? "heart.slash.fill" : "heart.fill")
                                                }
                                                Button("View Details") { }
                                            }
                                    }
                                    
                                    Button(action: {
                                        toggleFavorite(for: item)
                                    }) {
                                        Image(systemName: isFavorite(item) ? "heart.fill" : "heart")
                                            .foregroundColor(isFavorite(item) ? .red : .gray)
                                            .padding(8)
                                    }
                                }
                                
                                Text(item.type)
                                    .font(.headline)
                                
                                Text(item.price)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .searchable(text: $searchQuery)
            }
            .navigationTitle("Unhemmed")
            .toolbar {
                HStack {
                    NavigationLink(destination: CartView(cartItems: $cartItems)) {
                        HStack {
                            Image(systemName: "cart.fill")
                            Text("(\(cartItems.count))")
                                .bold()
                        }
                        .foregroundColor(.blue)
                    }
                    
                    NavigationLink(destination: FavoritesView(favoriteItems: $favoriteItems, allItems: clothingItems)) {
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("Favorites")
                                .bold()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private func toggleFavorite(for item: ClothingItem) {
        if let isFav = favoriteItems[item.id] {
            favoriteItems[item.id] = !isFav
        } else {
            favoriteItems[item.id] = true
        }
    }
    
    private func isFavorite(_ item: ClothingItem) -> Bool {
        return favoriteItems[item.id] ?? false
    }
}

#Preview {
    ContentView()
}
