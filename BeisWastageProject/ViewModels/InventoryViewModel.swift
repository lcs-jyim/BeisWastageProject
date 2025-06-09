//
//  WastageViewModel.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/7.
//

import Foundation
import OSLog
import Supabase

@Observable
class InventoryViewModel {
    var allIngredient:[Ingredient] = []
    var purchases: [IVPurchase] = []
    
    private let db: DatabaseConnection
    
    init(using db: DatabaseConnection) {
        self.db = db
        Logger.database.info("Initializing IventoryViewModel.")
        
        Task {
            await self.getAllInventory()
            await self.getAllPurchases()
        }
    }
    func getAllInventory() async {
        Logger.database.info("Fetching all Inventory")
        do {
            let results:[Ingredient] = try await db.supabase
                .from("ingredients")
                .select()
                .execute()
                .value
            self.allIngredient = results
            Logger.database.info("In getAllInventory: There were \(self.allIngredient.count) rows returned.")
            Logger.database.info("Inventories successfully fetched and updated.")
        } catch {
            Logger.database.error("Failed to fetch Inventories: \(error.localizedDescription)")
            
        }
    }
    
    func getAllPurchases() async {
        Logger.database.info("Fetching all Inventory")
        do {
            let results:[IVPurchase] = try await db.supabase
                .from("purchases")
                .select()
                .execute()
                .value
            self.purchases = results
            Logger.database.info("In getAllPurchases: There were \(self.purchases.count) rows returned.")
            Logger.database.info("Inventories successfully fetched and updated.")
        } catch {
            Logger.database.error("Failed to fetch Purchases: \(error.localizedDescription)")
        }
    }
    func submitPurchase(ingredientId: Int, quantityPurchased: Double, date: Date, quantityInStock: Double) async {
        do {
            let newEntry = IVPurchase(ingredientId: ingredientId, quantityInStock:quantityInStock, quantityPurchased: quantityPurchased, date: date)

            try await db.supabase
                .from("purchases")
                .insert(newEntry)
                .execute()
            
            
            Logger.database.info("Purchase successfully inserted.")
            await getAllPurchases()
        } catch {
            Logger.database.error("Failed to insert purchase: \(error.localizedDescription)")
        }
    }


}

