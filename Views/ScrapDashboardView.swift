//
//  ScrapDashboardView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/4.
//

import SwiftUI

struct ScrapDashboardView: View {
    @Environment(SalesViewModel.self) private var viewModel
    
    @State private var searchText = ""
    @State private var selectedProduct: Product?
    @State private var scrapQuantity = ""
    @State private var scrapDate: Date = .now
    @State private var scrapItems: [previewListType] = []
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessAlert = false
    @State private var successMessage = ""
    
    var filteredProducts: [Product] {
        searchText.isEmpty
        ? []
        : viewModel.allProducts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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
                    Text("选中产品: \(selected.name)").foregroundColor(.gray)
                }
                
                TextField("报损数量", text: $scrapQuantity)
                    .keyboardType(.decimalPad)
                
                DatePicker("报损日期", selection: $scrapDate, displayedComponents: .date)
                
                Button("➕ 添加记录") {
                    guard let product = selectedProduct,
                          !scrapQuantity.isEmpty else {
                        alertMessage = "请选中一个产品并输入有效的数量"
                        showAlert = true
                        return
                    }
                    
                    scrapItems.append(
                        previewListType(product: product, quantity: scrapQuantity, date: scrapDate)
                    )
                    
                    // Reset
                    searchText = ""
                    selectedProduct = nil
                    scrapQuantity = ""
                    scrapDate = .now
                }
            }
            
            // 📋 Review
            Section(header: Text("📋 报损列表")) {
                if scrapItems.isEmpty {
                    Text("当前无报损记录").foregroundColor(.secondary)
                } else {
                    ForEach(scrapItems) { xitem in
                        VStack(alignment: .leading) {
                            Text(xitem.product.name)
                                .fontWeight(.semibold)
                            HStack {
                                Text("数量:")
                                Text(xitem.quantity)
                            }
                                
                            
                            
                            Text("日期: \(xitem.date.formatted(date: .abbreviated, time: .omitted))")
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
                    Task {
                        await handleSubmit()
                    }
                }
            }
        }
        .navigationTitle("报损管理")
        .alert("错误", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .alert("成功!", isPresented:$showSuccessAlert){
            Button("好",role:.cancel){}
        } message:{
            Text(successMessage)
        }
    }
    
    private func handleSubmit() async {
        for item in scrapItems {
            if let quantity = Int(item.quantity) {
                await viewModel.submitScrapData(
                    productId: item.product.id,
                    quantity: quantity,
                    date: item.date
                )
                
                successMessage = "所有报损记录已成功提交。"
                showSuccessAlert = true
                scrapItems.removeAll()
            }
        }
    }
    
}
#Preview {
    ScrapDashboardView()
}
