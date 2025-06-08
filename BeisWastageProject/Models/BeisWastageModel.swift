import Foundation

// MARK: - Ingredient
struct Ingredient: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var unit: String
}

// MARK: - Product
struct Product: Identifiable, Codable {
    var id: Int
    var name: String
}

// MARK: - RecipeItem (Join Table)
struct RecipeItem: Identifiable, Codable {
    var id: Int
    var productId: Int
    var ingredientId: Int
    var quantityPerUnit: Double
}


// MARK: - PurchaseEntry
struct IVPurchase: Identifiable, Codable {
    var id: Int
    var ingredientId: Int
    var quantity: Double
    var date: Date
}

// MARK: - WastageEntry
struct WastageEntry: Identifiable, Codable {
    var id: Int
    var ingredientId: Int
    var startTime: Date
    var endTime: Date
    var expectedUsage: Double
    var actualUsage: Double
    
    var loss: Double {
        actualUsage - expectedUsage
    }
}
//MARK: - ScrapProductEntry
struct ScrapProductEntry: Identifiable, Codable {
    let id = UUID()
    var product: Product
    var quantity: String  // store as string for editing
    var date: Date
}

struct SalesEntry: Identifiable {
    let id = UUID()
    var product: Int
    var quantity: Int
    var date: Date
    var channel: SalesChannel
}

enum SalesChannel: String, CaseIterable, Identifiable, Codable {
    case 美团, 饿了么, 有赞, 店内
    
    var id: String { self.rawValue }
}



