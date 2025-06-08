//
//  InventoryDashboardView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/2.
//

import SwiftUI

struct InventoryDashboardView: View {
    @Environment(InventoryViewModel.self) private var viewModel

    @State private var searchText: String = ""
    @State private var selectedIngredient: Ingredient?
    @State private var purchaseQuantity: String = ""
    @State private var remainingQuantity: String = ""
    @State private var purchaseDate: Date = .now

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessAlert = false
    @State private var successMessage = ""

    var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return []
        } else {
            return viewModel.allIngredient.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        Form {
            // 🔍 Search & Select
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
                    Text("已选中: \(selected.name) (\(selected.unit))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            // ➕ Add Purchase
            Section(header: Text("➕ 添加入库单")) {
                if selectedIngredient == nil {
                    Text("请选择原材料").foregroundColor(.secondary)
                }

                TextField("入库前剩余库存数量", text: $remainingQuantity)
                    .keyboardType(.decimalPad)

                TextField("入库数量", text: $purchaseQuantity)
                    .keyboardType(.decimalPad)

                DatePicker("日期", selection: $purchaseDate, displayedComponents: .date)

                Button("上传入库数据") {
                    Task {
                        await handleSubmit()
                    }
                }
                .disabled(selectedIngredient == nil)
                .alert("错误！", isPresented: $showAlert) {
                    Button("好", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }
                .alert("成功！", isPresented: $showSuccessAlert) {
                    Button("好的", role: .cancel) { }
                } message: {
                    Text(successMessage)
                }
            }
        }
        .navigationTitle("库存管理")
    }

    private func handleSubmit() async {
        guard let ingredient = selectedIngredient else {
            alertMessage = "请选择一项原材料。"
            showAlert = true
            return
        }

        guard let quantity = Double(purchaseQuantity), quantity > 0 else {
            alertMessage = "请输入有效的入库数量。"
            showAlert = true
            return
        }

        guard let _ = Double(remainingQuantity), Double(remainingQuantity)! >= 0 else {
            alertMessage = "请输入有效的剩余库存。"
            showAlert = true
            return
        }

        guard let quantityPurchased = Double(purchaseQuantity),
              let quantityInStock = Double(remainingQuantity) else {
            alertMessage = "请确保入库数量和剩余库存都是可用数字。"
            showAlert = true
            return
        }

        await viewModel.submitPurchase(
            ingredientId: ingredient.id,
            quantityPurchased: quantityPurchased,
            date: purchaseDate,
            quantityInStock: quantityInStock
        )

        successMessage = "\(quantity) \(ingredient.unit) 的 \(ingredient.name) 已成功录入系统。"
        showSuccessAlert = true

        // Clear fields
        searchText = ""
        purchaseQuantity = ""
        remainingQuantity = ""
        selectedIngredient = nil
        purchaseDate = .now
    }
}

#Preview {
   InventoryDashboardView()
}
