//
//  BeisWastageProjectApp.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/5/31.
//

import SwiftUI

@main
struct BeisWastageProjectApp: App {
    let db = DatabaseConnection()
    @State private var inventoryVM = InventoryViewModel(using: DatabaseConnection())
    @State private var salesVM = SalesViewModel(using: DatabaseConnection())
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environment(inventoryVM)
            .environment(salesVM)// ✅ Inject here once for the whole app
        }
    }
}

