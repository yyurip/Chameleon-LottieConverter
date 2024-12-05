//
//  PreviewAnimationViewModel.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 01.12.24.
//

import Foundation

struct PreviewAnimationViewModel {
    
    func loadJsonFiles(directory: URL?) -> [URL] {
        guard let directory else { return [] }
        let files = (try? FileManager.default.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: nil
        )
            .filter {
                $0.pathExtension == "json"
            }
        ) ?? []
        
        return files
    }
    
    func loadSelectedFile(
        directories: [URL],
        currentFile: URL?
    ) -> URL? {
        guard let currentFile
        else { return directories.first }
        
        return directories.first {
            $0.lastPathComponent == currentFile.lastPathComponent
        } ?? directories.first
    }
}
