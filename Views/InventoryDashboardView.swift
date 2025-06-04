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
    @State private var purchaseQuantity: String = ""
    @State private var purchaseDate: Date = .now
    @State private var remainingQuantity: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessAlert = false
    @State private var successMessage = ""
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
            Section(header: Text("🔍 检索您要录入的原材料")) {
                TextField("输入您要录入的原材料...", text: $searchText)

                ForEach(filteredIngredients) { ingredient in
                    Button {
                        selectedIngredient = ingredient
                        searchText = ingredient.name
                    } label: {
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Text(ingredient.unit)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                if let selected = selectedIngredient {
                    Text("Selected: \(selected.name) (\(selected.unit))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            // ➕ Add Purchase Section
            Section(header: Text("➕ 添加入库单")) {
                if let selected = selectedIngredient {
                    Text("Ingredient: \(selected.name)")
                } else {
                    Text("请选择原材料").foregroundColor(.secondary)
                }
                TextField("入库前剩余库存数量",text:$remainingQuantity)
                    .keyboardType(.decimalPad)
                
                TextField("入库数量", text:$purchaseQuantity)
                    .keyboardType(.decimalPad)
               

                DatePicker("日期", selection: $purchaseDate, displayedComponents: .date)

                Button("上传入库数据") {
                    guard let ingredient = selectedIngredient else {
                        alertMessage = "请选择一项原材料。"
                        showAlert = true
                        return
                    }

                    guard let quantity = Double(purchaseQuantity), quantity > 0 else {
                        alertMessage = "请输入有效的数字。"
                        showAlert = true
                        return
                    }
                    guard let rquantity = Double(remainingQuantity),rquantity > 0 else{
                        alertMessage = "请输入有效的数字。"
                        showAlert = true
                        return
                    }

                    print("Purchasing \(quantity) \(ingredient.unit) of \(ingredient.name) on \(purchaseDate)")
                    successMessage = " \(quantity) \(ingredient.unit) 的 \(ingredient.name)已成功录入系统。"
                        showSuccessAlert = true
                    searchText = ""
                    purchaseQuantity = ""
                    remainingQuantity = ""
                    selectedIngredient = nil
                    purchaseDate = .now

                    // TODO: Insert into Supabase
                }
                .alert("错误！", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }
                .alert("成功！", isPresented: $showSuccessAlert) {
                    Button("好", role: .cancel) { }
                } message: {
                    Text(successMessage)
                }
            }
        }
        .navigationTitle("库存管理")
    }
}
#Preview {
   InventoryDashboardView()
}
