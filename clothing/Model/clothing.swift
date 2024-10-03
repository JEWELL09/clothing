import SwiftUI

// Struct to define a Clothing item with image support
struct ClothingItem: Identifiable {
    var id = UUID()
    var type: String
    var stocks: Int
    var price: String
    var imageName: String
}
