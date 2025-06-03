//
//  InventoryDashboardView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/2.
//

import SwiftUI

struct InventoryDashboardView: View {
    @State private var searchText: String = ""
    @State private var selectedIngredient: Ingredient?
    @State private var purchaseQuantity: Double = 0
    @State private var purchaseDate: Date = .now

    // Replace with ViewModel fetch later
    @State private var ingredients: [Ingredient] = [
        Ingredient(id: 1, name: "Flour", unit: "kg"),
        Ingredient(id: 2, name: "Butter", unit: "kg"),
        Ingredient(id: 3, name: "Chocolate", unit: "kg")
    ]

    var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return []
        } else {
            return ingredients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        Form {
            // 🔍 Search Bar & Result List
            Section(header: Text("🔍 Search Ingredient")) {
                TextField("Type ingredient name...", text: $searchText)

                ForEach(filteredIngredients) { ingredient in
                    Button {
                        selectedIngredient = ingredient
                        searchText = ingredient.name
                    } label: {
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Text("\(ingredient.currentQuantity, specifier: "%.2f") \(ingredient.unit)")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                if let selected = selectedIngredient {
                    Text("Selected: \(selected.name) → \(selected.currentQuantity, specifier: "%.2f") \(selected.unit)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            // ➕ Add Purchase Section
            Section(header: Text("➕ Add Purchase")) {
                if let selected = selectedIngredient {
                    Text("Ingredient: \(selected.name)")
                } else {
                    Text("Please select an ingredient above").foregroundColor(.secondary)
                }

                TextField("Quantity", value: $purchaseQuantity, format: .number)
                    .keyboardType(.decimalPad)

                DatePicker("Date", selection: $purchaseDate, displayedComponents: .date)

                Button("Submit Purchase") {
                    guard let ingredient = selectedIngredient else { return }
                    print("Purchasing \(purchaseQuantity) \(ingredient.unit) of \(ingredient.name) on \(purchaseDate)")
                    // TODO: Insert into Supabase
                }
            }
        }
        .navigationTitle("Inventory")
    }
}
