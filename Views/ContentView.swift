//
//  ContentView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/5/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                Text("Who Are You?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 16)

                // 📦 Inventory Manager
                NavigationLink(destination: InventoryDashboardView()) {
                    Label("Inventory Manager", systemImage: "shippingbox")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }

                // 💸 Sales Manager
                NavigationLink(destination: SalesDashboardView()) {
                    Label("Sales Manager", systemImage: "dollarsign.circle")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }

                // 🧮 Wastage Viewer
                NavigationLink(destination: WastageReportView()) {
                    Label("Wastage Viewer", systemImage: "chart.bar.doc.horizontal")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("Beis Wastage System")
        }
    }
}

#Preview {
    ContentView()
}

