//
//  FoldersSelectionView.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 01.12.24.
//

import SwiftUI
import Lottie

struct FoldersSelectionView: View {
    @Binding var inputFolderURL: URL?
    @Binding var outputFolderURL: URL?
    var onSelectionChange: (()-> Void)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "tray.and.arrow.down")
                    .foregroundColor(.primary)
                    .frame(width: 24, height: 24)
                Text("Input folder")
                    .foregroundColor(.primary)
                    .bold()
            }
            HStack {
                HStack(alignment: .bottom) {
                    Text("Path:")
                        .foregroundColor(.secondary)
                        .font(.callout)
                        .bold()
                    
                    Text(inputFolderURL?.absoluteString ?? "Add input folder")
                        .foregroundColor(inputFolderURL == nil ? .secondary : .primary)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
                .border(.gray, width: 1.5)
                .cornerRadius(2.5)
                
                
                Button {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseFiles = false
                    panel.canChooseDirectories = true
                    if panel.runModal() == .OK {
                        self.inputFolderURL = panel.url
                        onSelectionChange()
                    }
                } label: {
                    Image(systemName:"folder.badge.plus")
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(PlainButtonStyle())
                .tint(.blue)
            }
            
            HStack {
                Image(systemName: "tray.and.arrow.up")
                    .foregroundColor(.primary)
                    .frame(width: 24, height: 24)
                Text("Output folder")
                    .foregroundColor(.primary)
                    .bold()
            }
            HStack {
                HStack(alignment: .bottom) {
                    Text("Path:")
                        .foregroundColor(.secondary)
                        .font(.callout)
                        .bold()
                    
                    Text(outputFolderURL?.absoluteString ?? "Add output folder")
                        .foregroundColor(outputFolderURL == nil ? .secondary : .primary)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
                .border(.gray, width: 1.5)
                .cornerRadius(2.5)
                
                Button {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseFiles = false
                    panel.canChooseDirectories = true
                    if panel.runModal() == .OK {
                        self.outputFolderURL = panel.url
                        onSelectionChange()
                    }
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(PlainButtonStyle())
                .tint(.blue)
            }
        }
    }
}

#Preview("No folders selected") {
    FoldersSelectionView(
        inputFolderURL: .constant(nil),
        outputFolderURL: .constant(nil), 
        onSelectionChange: {}
    )
}
#Preview("Folders selected") {
    FoldersSelectionView(
        inputFolderURL: .constant(URL.applicationDirectory),
        outputFolderURL: .constant(URL.applicationDirectory),
        onSelectionChange: {}
    )
}
