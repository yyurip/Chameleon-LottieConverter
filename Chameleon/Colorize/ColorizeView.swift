//
//  ColorizeView.swift
//  Charmeleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 22.11.24.
//

import SwiftUI
import SwiftData

struct ColorizeView: View {
    private let viewModel = ColorizeViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var brandList: [Brand]
    
    @State private var inputURL: URL?
    @State private var outputURL: URL?
    @State var selectedFile: URL?
    
    @State var previewEnabled = false
    @State var previewFolderFiles = [URL]()
    
    @State var showSuccessAlert = false
    @State var showErrorAlert = false
    @State var isColoring = false
    
    private var changesWhenColoring = 0
    
    var body: some View {
        VStack {
            ColorizeHeaderView()
            
            VStack {
                VStack(alignment: .leading) {
                    FoldersSelectionView(
                        inputFolderURL: $inputURL,
                        outputFolderURL: $outputURL,
                        onSelectionChange: {
                            updatePreviewFolders()
                        }
                    )
                    
                    BrandColorConfigurationView(modelContext: modelContext)
                    
                    HStack {
                        Button(action: {
                            isColoring = true
                            viewModel.colorizeFiles(
                                brandList: brandList,
                                inputFolder: inputURL,
                                destinationFolder: outputURL,
                                onSuccess: {
                                    updatePreviewFolders()
                                    isColoring = false
                                    showSuccessAlert = true
                                },
                                onError: {
                                    isColoring = false
                                    showErrorAlert = true
                                }
                            )
                        }, label: {
                            if isColoring {
                                ProgressView()
                                    .controlSize(.small)
                                    .frame(width: 80)
                                
                            } else {
                                Text("Colorize")
                                    .frame(width: 80)
                            }
                        })
                        .tint(.blue)
                        .disabled(inputURL == nil || outputURL == nil || isColoring || (brandList.first { $0.isSelected } == nil))
                        .buttonStyle(.borderedProminent)
                        
                        Button(previewEnabled ? "Hide Preview" : "Show Preview") {
                            previewEnabled = !previewEnabled
                        }
                        .disabled(inputURL == nil && outputURL == nil)
                    }
                }
                .padding()
                
                if previewEnabled {
                    PreviewAnimationView(previewFolders: $previewFolderFiles)
                }
            }
            .frame(minWidth: 400, maxWidth: 800)
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK") {
                    previewEnabled = true
                    showSuccessAlert.toggle()
                }
            } message: {
                Text("All the animations were processed!\n\(viewModel.changesWhenColoring) colors changed")
            }
        }
    }
    
    private func updatePreviewFolders() {
        previewFolderFiles = viewModel.loadPreviewFolders(
            inputFolderURL: inputURL,
            outputFolderURL: outputURL
        )
    }
}


#Preview("Dark Mode") {
    ColorizeView().preferredColorScheme(.dark)
}

#Preview("Light Mode") {
    ColorizeView().preferredColorScheme(.light)
}

enum ColorizeError: Error {
    case outputCreation
    case dataConvertion
}

extension URL {
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}

extension URL {
    func subDirectories() throws -> [URL] {
        guard hasDirectoryPath else { return [] }
        return try FileManager.default.contentsOfDirectory(
            at: self,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ).filter(\.hasDirectoryPath)
    }
}
