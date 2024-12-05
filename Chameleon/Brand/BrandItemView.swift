//
//  BrandItemView.swift
//  Charmeleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 22.11.24.
//

import SwiftUI
import SwiftData

struct BrandItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var brand: Brand
    var action: () -> Void
    var onBrandDeleted: () -> Void
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(brand.isSelected ? .blue : .gray)
            Text(brand.name)
            Spacer()
            
            Button {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseFiles = true
                panel.allowedContentTypes = [.json]
                panel.canChooseDirectories = false
                if panel.runModal() == .OK {
                    guard let url = panel.url,
                          let data = try? Data(contentsOf: url),
                          let decoded = try? JSONSerialization.jsonObject(
                              with: data,
                              options: []
                          ) as? [String: String]
                    else {
                        return
                    }
                    brand.mapping = decoded
                }
            } label: {
                Image(systemName: "tray.and.arrow.down")
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                action()
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                showDeleteAlert.toggle()
            } label: {
                Image(systemName: "trash")
            }
            .alert("Delete \(brand.name)?", isPresented: $showDeleteAlert) {
                Button("Delete") {
                    modelContext.delete(brand)
                    showDeleteAlert.toggle()
                    onBrandDeleted()
                }
                Button("Cancel", role: .cancel) { }
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.red)
        }
        .padding(4)
        .contentShape(Rectangle())
        .onTapGesture {
            brand.isSelected.toggle()
        }
    }
}

#Preview {
    BrandItemView(
        brand: .constant(Brand(
            name: "Brand",
            mapping: [:],
            isSelected: true
        )),
        action: {},
        onBrandDeleted: {}
    )
}


