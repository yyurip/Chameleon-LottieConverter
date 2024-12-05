//
//  EditBrandColorItemView.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 30.11.24.
//

import SwiftUI
import Combine

struct EditBrandColorItemView: View {
    @State var viewData: ViewData
    var onFocusChange: (Bool) -> Void
    
    @State private var firstText: String
    @State private var secondText: String
    @FocusState private var firstTextFocused: Bool
    @FocusState private var secondTextFocused: Bool
    
    init(viewData: ViewData, onFocusChange: @escaping (Bool) -> Void) {
        self.viewData = viewData
        self.onFocusChange = onFocusChange
        firstText = viewData.original
        secondText = viewData.new
    }
    
    var body: some View {
        HStack {
            TextField(
                firstText,
                text: $firstText
            )
            .onChange(of: firstText, { oldValue, newValue in
                if newValue.count > 6 {
                    firstText = oldValue
                    viewData.original = oldValue.uppercased()
                } else  {
                    viewData.original = newValue.uppercased()
                }
            })
            .focused($firstTextFocused)
            .onChange(of: firstTextFocused) { oldValue, newValue in
                firstTextFocused = newValue
                onFocusChanged()
            }
            
            Circle()
                .foregroundColor(
                    Color(hex: firstText)
                )
                .frame(width: 16, height: 16)
            
            Image(
                systemName: "arrow.left.arrow.right"
            )
            .frame(width: 16, height: 16)
            
            Circle()
                .foregroundColor(
                    Color(hex: secondText)
                )
                .frame(width: 16, height: 16)
            
            TextField(
                secondText,
                text: $secondText
            ).onChange(of: secondText) { oldValue, newValue in
                if newValue.count > 6 {
                    secondText = oldValue
                    viewData.new = oldValue.uppercased()
                } else  {
                    viewData.new = newValue.uppercased()
                }
            }
            .focused($secondTextFocused)
            .onChange(of: secondTextFocused) { oldValue, newValue in
                secondTextFocused = newValue
                onFocusChanged()
            }
            Button {
                viewData.onDelete()
            } label: {
                Image(systemName: "trash")
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.red)
            .padding(.trailing)
        }
    }
    
    func onFocusChanged() {
        if firstTextFocused || secondTextFocused {
            onFocusChange(true)
        } else {
            onFocusChange(false)
        }
    }
}

extension EditBrandColorItemView {
    class ViewData: Identifiable {
        var id: String {
            self.original
        }
        var original: String
        var new: String
        var onDelete: (() -> Void)
        
        init(original: String, new: String, onDelete: @escaping (() -> Void)) {
            self.original = original
            self.new = new
            self.onDelete = onDelete
        }
    }
}

public extension String {
    func isValidHexColor() -> Bool {
        do {
            let regex = try Regex("^(?:[0-9a-fA-F]{3}){1,2}$")
            if let _ = try regex.firstMatch(in: self) {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

#Preview {
    EditBrandColorItemView(
        viewData: EditBrandColorItemView.ViewData(original: "FFFFFF", new: "000000", onDelete: {}),
        onFocusChange: { _ in }
    )
}
