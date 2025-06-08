//
//  ContentView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/5/31.
//

import SwiftUI

struct ContentView: View {
    let db = DatabaseConnection()
        @State private var inventoryVM: InventoryViewModel

        init() {
            inventoryVM = InventoryViewModel(using: db)
        }
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                Text("我要进行...操作")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 16)

                // 📦 Inventory Manager
                NavigationLink(destination: InventoryDashboardView()) {
                    Label("库存管理", systemImage: "shippingbox")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }

                // 💸 Sales Manager
                NavigationLink(destination: SalesDashboardView()) {
                    Label("销售管理", systemImage: "dollarsign.circle")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }

                // 🧮 Wastage Viewer
                NavigationLink(destination: WastageReportView()) {
                    Label("损耗管理及查看库存", systemImage: "chart.bar.doc.horizontal")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("贝家损耗管理系统")
        }
    }
}

#Preview {
    ContentView()
}

