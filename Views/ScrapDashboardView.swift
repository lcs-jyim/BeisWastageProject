//
//  ScrapDashboardView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/4.
//

import SwiftUI

struct ScrapDashboardView: View {
    @State private var searchText = ""
    @State private var selectedProduct: Product?
    @State private var scrapQuantity = ""
    @State private var scrapDate: Date = .now
    @State private var scrapItems: [ScrapProductEntry] = []

    @State private var showAlert = false
    @State private var alertMessage = ""

    // Replace with actual fetch from DB later
    let products: [Product] = [
        Product(id: 1, name: "Tiramisu Cake"),
        Product(id: 2, name: "Mango Roll"),
        Product(id: 3, name: "Chocolate Croissant")
    ]

    var filteredProducts: [Product] {
        searchText.isEmpty
        ? []
        : products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        Form {
            // 🔍 Search
            Section(header: Text("🔍 选择要报损的产品")) {
                TextField("搜索产品名称", text: $searchText)

                ForEach(filteredProducts) { product in
                    Button {
                        selectedProduct = product
                        searchText = product.name
                    } label: {
                        Text(product.name)
                    }
                }

                if let selected = selectedProduct {
                    Text("选中产品: \(selected.name)")
                        .foregroundColor(.gray)
                }

                TextField("报损数量", text: $scrapQuantity)
                    .keyboardType(.decimalPad)

                DatePicker("报损日期", selection: $scrapDate, displayedComponents: .date)

                Button("➕ 添加记录") {
                    guard let product = selectedProduct,
                          let _ = Double(scrapQuantity),
                          !scrapQuantity.isEmpty else {
                        alertMessage = "请选中一个产品并输入有效的数量"
                        showAlert = true
                        return
                    }

                    let newScrap = ScrapProductEntry(product: product, quantity: scrapQuantity, date: scrapDate)
                    scrapItems.append(newScrap)

                    // Reset
                    searchText = ""
                    selectedProduct = nil
                    scrapQuantity = ""
                    scrapDate = .now
                }
            }

            // 📝 Review
            Section(header: Text("📋 报损列表")) {
                if scrapItems.isEmpty {
                    Text("当前无报损记录")
                        .foregroundColor(.secondary)
                } else {
                    ForEach($scrapItems) { $item in
                        VStack(alignment: .leading) {
                            Text(item.product.name)
                                .fontWeight(.semibold)
                            HStack {
                                Text("数量:")
                                TextField("数量", text: $item.quantity)
                                    .keyboardType(.decimalPad)
                                    .frame(width: 80)
                            }
                            Text("日期: \(item.date.formatted(date: .abbreviated, time: .omitted))")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete { scrapItems.remove(atOffsets: $0) }
                }
            }

            // ✅ Submit
            if !scrapItems.isEmpty {
                Button("📤 提交报损记录") {
                    print("Submitting: \(scrapItems)")
                    // TODO: Submit to Supabase
                    scrapItems.removeAll()
                }
            }
        }
        .navigationTitle("报损管理")
        .alert("错误", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}


#Preview {
    ScrapDashboardView()
}
