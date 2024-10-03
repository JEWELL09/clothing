import SwiftUI

// View to display favorite items
struct FavoritesView: View {
    @Binding var favoriteItems: [UUID: Bool] // Binding for favorite status tracking
    var allItems: [ClothingItem] // All items to filter the favorite ones
    
    // Computed property to filter the favorite items
    var favoriteList: [ClothingItem] {
        allItems.filter { favoriteItems[$0.id] ?? false }
    }
    
    // For a 2-column grid layout
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        VStack {
            if favoriteList.isEmpty {
                // If no items are favorited, show this message
                Text("No favorite items")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Display grid of favorite items
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(favoriteList) { item in
                            // Wrap the item in a NavigationLink to view details when tapped
                            NavigationLink(destination: ClothingDetailView(item: item, cartItems: .constant([]))) {
                                VStack {
                                    // Display the image and info for each favorite item
                                    Image(item.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    Text(item.type)
                                        .font(.headline)
                                    
                                    Text(item.price)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Favorite Items") // Set navigation title
    }
}

#Preview {
    FavoritesView(favoriteItems: .constant([UUID(): true]), allItems: [
        ClothingItem(type: "Hiraya", stocks: 20, price: "₱299", imageName: "c1"),
        ClothingItem(type: "Nicole", stocks: 15, price: "₱359", imageName: "c2")
    ])
}
