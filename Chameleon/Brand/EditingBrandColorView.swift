//
//  EditingBrandColorView.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 30.11.24.
//

import Foundation

import SwiftUI

struct EditingBrandColorView: View {
    @Binding var viewData: ViewData
    var onStopEditingColorTap: (()->Void)?
    var onSaveChangesTap: (()->Void)?
    var onAddNewColorTap: ((String, String)->Void)?
    
    @State private var buttonEnabled = false
    @State private var isEditing = false
    @State private var isErrorAlertPresented = false
    @State private var newColorAlertPresented = false
    @State private var newColorError = false
    @State private var newColor = ""
    @State private var originalColor = ""
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                Text(viewData.brand.name)
                    .font(.title)
                VStack {
                    ForEach(viewData.fields, id: \.id) { field in
                        EditBrandColorItemView(
                            viewData: field,
                            onFocusChange: { focused in }
                        )
                    }
                }
                .frame(width: 300)
                
                HStack {
                    Button("Cancel") {
                        onStopEditingColorTap?()
                    }
                    Button("Add New") {
                        newColorAlertPresented.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    Button("Save changes") {
                        onSaveChanges()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            Spacer()
        }
        .alert("Invalid color", isPresented: $isErrorAlertPresented) {
            Button("OK") {
                isErrorAlertPresented.toggle()
                if newColorError {
                    newColorAlertPresented = true
                }
            }
            
        } message: {
            Text("Please check if there is any invalid hex color")
        }
        .alert("Add new color", isPresented: $newColorAlertPresented) {
            VStack {
                TextField("Original Color", text: $originalColor)
                TextField("New Color", text: $newColor)
                HStack {
                    Button("OK") {
                        guard originalColor.isValidHexColor(),
                              newColor.isValidHexColor()
                        else {
                            newColorError = true
                            isErrorAlertPresented = true
                            return
                        }
                        onAddNewColorTap?(originalColor, newColor)
                        newColorAlertPresented.toggle()
                    }
                    
                    Button("Cancel") {
                        newColorAlertPresented.toggle()
                    }
                }
            }
            
        } message: {
            Text("Please check if there is any invalid hex color")
        }
    }
    
    func onSaveChanges() {
        let allSatisfy = viewData.fields.allSatisfy {
            $0.original.isValidHexColor() && $0.new.isValidHexColor()
        }
        
        guard allSatisfy 
        else {
            isErrorAlertPresented.toggle()
            return
        }
        
        onSaveChangesTap?()
    }
}

extension EditingBrandColorView {
    struct ViewData {
        let brand: Brand
        let fields: [EditBrandColorItemView.ViewData]
    }
}

#Preview {
    EditingBrandColorView(
        viewData: .constant(EditingBrandColorView.ViewData(
            brand: .init(
                name: "Name",
                mapping: [:],
                isSelected: false
            ),
            fields: [EditBrandColorItemView.ViewData(
                original: "FF00FF",
                new: "0000FF",
                onDelete: {}
            )]
        ))
    )
}
