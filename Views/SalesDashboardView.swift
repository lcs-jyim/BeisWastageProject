//
//  SalesDashboardView.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/2.
//

import SwiftUI

struct SalesDashboardView: View {
    var body: some View {
        Text("我要录入...")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 16)
        
        NavigationLink(destination: ScrapDashboardView()) {
            Label("报废面包", systemImage: "shippingbox")
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
        }

        
        NavigationLink(destination: SalesDataDashboardView()) {
            Label("销售数量", systemImage: "dollarsign.circle")
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
        }
    }
}

#Preview {
    SalesDashboardView()
}
