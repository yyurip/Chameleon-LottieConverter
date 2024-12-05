//
//  BrandColorMappingView.swift
//  Charmeleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 18.11.24.
//

import Foundation
import SwiftUI
import SwiftData

struct BrandColorConfigurationView: View {
    @StateObject private var viewModel: BrandColorConfigurationViewModelImpl
    @Environment(\.modelContext) private var modelContext
    @Query private var brandList: [Brand]
    
    init(modelContext: ModelContext) {
        let viewModel = BrandColorConfigurationViewModelImpl(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let editingBrand = viewModel.viewData?.editingBrand {
                EditingBrandColorView(
                    viewData: .constant(editingBrand),
                    onStopEditingColorTap: {
                        viewModel.stopEditingColor()
                    }, 
                    onSaveChangesTap: {
                        viewModel.saveChanges()
                    },
                    onAddNewColorTap: { origin, new in
                        viewModel.addNewColor(original: origin, new: new)
                    }
                )
            } else {
                BrandColorListView(
                    onStartEditingTap: { brand in
                        viewModel.startEditingColor(for: brand)
                    }
                )
            }
        }
        .padding()
        .frame(height: 350)
    }
}

#Preview("Empty List") {
    let container = try! ModelContainer(
        for: Brand.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    return BrandColorConfigurationView(modelContext: container.mainContext)
        .modelContainer(for: Brand.self, inMemory: true)
}

#Preview("List of Brands") {
    let container = try! ModelContainer(
        for: Brand.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    container.mainContext.insert(Brand(name: "Brand1", mapping: [:], isSelected: true))
    container.mainContext.insert(Brand(name: "Brand2", mapping: ["":""], isSelected: false))
    
    return BrandColorConfigurationView(modelContext: container.mainContext)
        .modelContainer(container)
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
