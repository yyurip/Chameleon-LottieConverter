//
//  BrandColorConfigurationViewModel.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 30.11.24.
//

import SwiftUI
import SwiftData

extension BrandColorConfigurationView {
    struct ViewData {
        let brands: [Brand]
        var editingBrand: EditingBrandColorView.ViewData?
    }
}
protocol BrandColorConfigurationViewModel: ObservableObject {
    func startEditingColor(for brand: Brand)
    func stopEditingColor()
}

class BrandColorConfigurationViewModelImpl: BrandColorConfigurationViewModel {
    @Published var viewData: BrandColorConfigurationView.ViewData?
    @Published var text: String = ""
    @Published var texts: [String:String] = [:]
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadBrands()
    }
    
    func startEditingColor(for brand: Brand) {
        viewData?.editingBrand = EditingBrandColorView.ViewData(
            brand: brand,
            fields: brand.mapping.keys.map { key in
                EditBrandColorItemView.ViewData(
                    original: key,
                    new: brand.mapping[key] ?? "",
                    onDelete: { [weak self] in
                        brand.mapping.removeValue(forKey: key)
                        self?.startEditingColor(for: brand)
                    }
                )
            }
        )
    }
    
    func stopEditingColor() {
        viewData?.editingBrand = nil
    }
    
    func addNewColor(original: String, new: String) {
        guard let editingBrand = viewData?.editingBrand?.brand
        else { return }
        viewData?.editingBrand?.brand.mapping[original.uppercased()] = new.uppercased()
        startEditingColor(for: editingBrand)
    }
    
    func update(mapping: [String: String], for brand: Brand?) {
        brand?.mapping = mapping
    }
    
    func saveChanges() {
        var mapping = [String:String]()
        viewData?.editingBrand?.fields.forEach { field in
            mapping[field.original] = field.new
        }
        viewData?.editingBrand?.brand.mapping = mapping
        viewData?.editingBrand = nil
    }
    
    func loadBrands() {
        do {
            let descriptor = FetchDescriptor<Brand>()
            let brands = try modelContext.fetch(descriptor)
            viewData = BrandColorConfigurationView.ViewData(brands: brands, editingBrand: nil)
        } catch {
            print("Fetch failed")
        }
    }
}
