import Foundation

// MARK: - Ingredient
struct Ingredient: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var unit: String
    var cny_per_unit:Double
    var grams_per_unit:Int
    var cny_per_gram:Double
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
    var id: Int?
    var ingredientId: Int
    var quantityInStock: Double
    var quantityPurchased:Double
    var date: Date
    enum CodingKeys:String,CodingKey{
        case id
        case ingredientId = "ingredient_id"
        case quantityInStock = "quantity_in_stock"
        case date
        case quantityPurchased = "quantity_purchased"
    }
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
    var id: Int?
    var product: Int
    var quantity: Int  // store as string for editing
    var date: Date
    
    enum CodingKeys:String, CodingKey {
        case id
        case product = "product_id"
        case quantity
        case date
    }
}

struct SalesEntry: Identifiable, Codable {
    var id: Int?
    var product: Int
    var quantity: Int
    var date: Date
    var channel: SalesChannel

    enum CodingKeys: String, CodingKey {
        case id
        case product = "product_id"
        case quantity = "quantity_sold"
        case date
        case channel  // this will encode/decode as the string rawValue like "美团"
    }
}


enum SalesChannel: String, CaseIterable, Identifiable, Codable {
    case 美团, 饿了么, 有赞, 店内
    
    var id: String { self.rawValue }
}

struct previewListType: Identifiable, Codable {
    var id = UUID()
    var product:Product
    var quantity: String
    var date: Date
}
