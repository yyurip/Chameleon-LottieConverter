//
//  PreviewAnimationView.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 01.12.24.
//

import SwiftUI
import Lottie

struct PreviewAnimationView: View {
    private let viewModel = PreviewAnimationViewModel()
    @Binding var previewFolders: [URL]
    @State var selectedPreviewFolder: URL?
    @State var previewFiles = [URL]()
    @State var selectedPreviewFile: URL?
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                //Folders
                VStack(alignment: .leading) {
                    Text("Folders")
                        .font(.headline)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                    
                    Divider()
                    
                    List(previewFolders, id: \.self, selection: $selectedPreviewFolder) { item in
                        ZStack {
                            HStack {
                                Image(systemName: "folder")
                                Text(item.lastPathComponent)
                            }
                            .padding(2)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .onChange(of: selectedPreviewFolder) { old, new in
                        previewFiles = viewModel.loadJsonFiles(directory: new)
                        selectedPreviewFile = viewModel.loadSelectedFile(
                            directories: previewFiles,
                            currentFile: selectedPreviewFile
                        )
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Animations")
                        .font(.headline)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                    
                    Divider()
                    
                    List(previewFiles, id: \.self, selection: $selectedPreviewFile) { file in
                        Text(file.lastPathComponent)
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                
                ZStack {
                    if let selectedPreviewFile {
                        LottieView(animation: .filepath(selectedPreviewFile.path()))
                            .looping()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                            .background()
                            .frame(width: 200, height: 200)
                    } else {
                        Text("Preview")
                            .frame(width: 200, height: 200)
                            .background()
                    }
                }.frame(width: 300, height: 300)
            }
            .padding(.all)
        }
    }
}

#Preview {
    PreviewAnimationView(previewFolders: .constant([]))
}
