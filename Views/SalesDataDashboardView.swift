//
//  SalesDataDashboardView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/4.
//

import SwiftUI

struct SalesDataDashboardView: View {
    @State private var selectedChannel: SalesChannel = .美团
    @State private var searchText = ""
    @State private var selectedProduct: Product?
    @State private var quantitySold = ""
    @State private var saleDate = Date()
    @State private var salesList: [SalesEntry] = []
    
    @State private var showAlert = false
    @State private var alertMessage = ""

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
            // 📦 Sales Channel Picker
            Section(header: Text("📌 选择销售渠道")) {
                Picker("渠道", selection: $selectedChannel) {
                    ForEach(SalesChannel.allCases) { channel in
                        Text(channel.rawValue).tag(channel)
                    }
                }
                .pickerStyle(.segmented)
            }

            // 🔍 Product Search and Entry
            Section(header: Text("🛒 添加销售记录")) {
                TextField("搜索产品", text: $searchText)

                ForEach(filteredProducts) { product in
                    Button {
                        selectedProduct = product
                        searchText = product.name
                    } label: {
                        Text(product.name)
                    }
                }

                if let selected = selectedProduct {
                    Text("选中产品: \(selected.name)").foregroundColor(.gray)
                }

                TextField("销售数量", text: $quantitySold)
                    .keyboardType(.decimalPad)

                DatePicker("销售日期", selection: $saleDate, displayedComponents: .date)

                Button("➕ 添加到销售列表") {
                    guard let product = selectedProduct,
                          let _ = Int(quantitySold),
                          !quantitySold.isEmpty else {
                        alertMessage = "请输入有效产品与数量"
                        showAlert = true
                        return
                    }

                    salesList.append(TempSalesEntry(
                        product: product,
                        quantity: quantitySold,
                        date: saleDate,
                        channel: selectedChannel
                    ))

                    // Reset
                    searchText = ""
                    selectedProduct = nil
                    quantitySold = ""
                    saleDate = Date()
                }
            }

            // 📋 Sales List
            Section(header: Text("📋 当前销售记录")) {
                if salesList.isEmpty {
                    Text("无销售记录").foregroundColor(.secondary)
                } else {
                    ForEach($salesList) { $item in
                        VStack(alignment: .leading) {
                            Text("\(item.product.name)（\(item.channel.rawValue)）")
                                .fontWeight(.semibold)

                            HStack {
                                Text("数量:")
                                TextField("数量", text: $item.quantity)
                                    .keyboardType(.numberPad)
                                    .frame(width: 80)
                            }

                            Text("日期: \(item.date.formatted(date: .abbreviated, time: .omitted))")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete { salesList.remove(atOffsets: $0) }
                }
            }

            // ✅ Submit All
            if !salesList.isEmpty {
                Button("📤 提交所有销售记录") {
                    print("提交: \(salesList)")
                    // TODO: Upload to Supabase or export for RPA
                    salesList.removeAll()
                }
            }
        }
        .navigationTitle("销售录入")
        .alert("错误", isPresented: $showAlert) {
            Button("好", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        
    }
}


#Preview {
    SalesDataDashboardView()
}
