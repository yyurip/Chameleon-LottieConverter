//
//  BrandColorListView.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 30.11.24.
//

import Foundation

import SwiftUI
import SwiftData

struct BrandColorListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var brandList: [Brand]
    @State private var showNewBrandAlert = false
    @State private var buttonEnabled = false
    @State private var newBrandName = ""
    var onStartEditingTap: ((Brand)->Void)?
    
    init(
        onStartEditingTap: ((Brand) -> Void)? = nil
    ) {
        self.onStartEditingTap = onStartEditingTap
        showNewBrandAlert = false
        buttonEnabled = false
        newBrandName = ""
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Select a brand")
            if brandList.isEmpty {
                ContentUnavailableView(
                    "Brands",
                    systemImage: "exclamationmark.bubble",
                    description: Text("No brands yet. Add one to start.")
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            } else {
                List {
                    ForEach(brandList, id: \.id) { brand in
                        BrandItemView(
                            brand: .constant(brand),
                            action: {
                                onStartEditingTap?(brand)
                            },
                            onBrandDeleted: {
                                print(brandList.map{$0.name})
                            }
                        )
                    }
                }
                .frame(minHeight: 150)
            }
            Button {
                showNewBrandAlert.toggle()
            } label: {
                Image(systemName: "plus")
                    .frame(width: 24, height: 24)
                Text("New brand")
            }
            .buttonStyle(PlainButtonStyle())
            .alert("Add a new Brand", isPresented: $showNewBrandAlert) {
                TextField("Brand name", text: $newBrandName)
                Button("OK") {
                    modelContext.insert(
                        Brand(
                            name: newBrandName,
                            mapping: [:],
                            isSelected: false
                        )
                    )
                    showNewBrandAlert.toggle()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please enter the brand name.")
            }
        }
    }
}

#Preview {
    BrandColorListView()
}
