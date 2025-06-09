//
//  SalesViewModel.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/8.
//

import Foundation
import OSLog
import Supabase

@Observable
class SalesViewModel {
    private let db: DatabaseConnection
    var allProducts:[Product] = []
    
    
    
    init(using db: DatabaseConnection) {
        self.db = db
        Logger.database.info("Initializing SalesViewModel.")
        
        Task {
            await self.getAllProducts()
        }
    }
    func getAllProducts() async {
        Logger.database.info("Fetching all Products")
        do {
            let results:[Product] = try await db.supabase
                .from("products")
                .select()
                .execute()
                .value
            self.allProducts = results
            Logger.database.info("In getAllProducts: There were \(self.allProducts.count) rows returned.")
            Logger.database.info("All Products successfully fetched and updated.")
        } catch {
            Logger.database.error("Failed to fetch Products: \(error.localizedDescription)")
            
        }
    }
    func submitSalesData(productId: Int, quantity: Int, date: Date, channel: SalesChannel) async {
        do {
            let newEntry = SalesEntry(product: productId, quantity: quantity, date: date, channel: channel)

            try await db.supabase
                .from("sales")
                .insert(newEntry)
                .execute()
            
            
            Logger.database.info("Sales successfully inserted.")
            await getAllProducts()
        } catch {
            Logger.database.error("Failed to insert Sales Entry: \(error.localizedDescription)")
        }
    }
    func submitScrapData(productId:Int,quantity:Int,date:Date) async {
        do {
            let newEntry = ScrapProductEntry(product: productId, quantity: quantity, date: date)
            
            try await db.supabase
                .from("scrapped_items")
                .insert(newEntry)
                .execute()
            
            Logger.database.info("scrapped item successfully inserted.")
            await getAllProducts()
        } catch {
            Logger.database.error("Failed to insert scrapped Item Entry: \(error.localizedDescription)")
        }
            
        }

    
}
