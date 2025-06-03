import Foundation

// MARK: - Ingredient
struct Ingredient: Identifiable, Codable,Hashable {
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

// MARK: - SaleEntry
struct SaleEntry: Identifiable, Codable {
    var id: Int
    var productId: Int
    var quantitySold: Int
    var date: Date
}

// MARK: - PurchaseEntry
struct PurchaseEntry: Identifiable, Codable {
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
