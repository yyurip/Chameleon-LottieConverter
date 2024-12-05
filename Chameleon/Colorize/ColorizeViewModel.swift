//
//  ColorizeViewModel.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 01.12.24.
//

import Foundation
import LottieColorize
import Zip

class ColorizeViewModel {
    var changesWhenColoring = 0
    
    func colorizeFiles(
        brandList: [Brand],
        inputFolder: URL?,
        destinationFolder: URL?,
        onSuccess: (() -> Void),
        onError: (() -> Void)
    ) {
        var process = 0
        var results = [ColorizeResult]()
        brandList
            .filter { $0.isSelected }
            .forEach { brand in
                loadFiles(directory: inputFolder).forEach { url in
                    process += 1
                    do {
                        let result = try colorize(
                            url: url,
                            configFile: brand.mapping,
                            brandName: brand.name,
                            destinationFolder: destinationFolder
                        )
                        results.append(result)
                    } catch {
                        print(error)
                    }
                }
            }
        if results.count != process {
            onError()
        } else {
            changesWhenColoring = results.map { $0.changes }.reduce(0, +)
            onSuccess()
        }
    }
    
    func colorize(
        url: URL?,
        configFile: [String:String],
        brandName: String,
        destinationFolder: URL?
    ) throws -> ColorizeResult {
        guard let url,
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any]
        else {
            throw ColorizeError.dataConvertion
        }
        
        let defaultURL = try outputDirectoryURL(
            for: brandName,
            destinationFolder: destinationFolder
        )
        let destination = defaultURL.appending(path: url.lastPathComponent)
        
        return try LottieColorize.colorize(
            input: json,
            with: configFile,
            destination: destination
        )
    }
    
    func outputDirectoryURL(
        for brand: String,
        destinationFolder: URL?
    ) throws -> URL {
        guard let destinationFolder else {
            throw ColorizeError.outputCreation
        }
        let brandFolderURL = destinationFolder.appending(path: brand.lowercased())
        guard !FileManager.default.fileExists(atPath: brandFolderURL.path)
        else { return brandFolderURL }
        
        do {
            try FileManager.default.createDirectory(
                atPath: brandFolderURL.path,
                withIntermediateDirectories: true,
                attributes: nil
            )
            return brandFolderURL
        }
        catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
            throw error
        }
    }
    
    func loadFiles(directory: URL?) -> [URL] {
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
    
    func loadPreviewFolders(
        inputFolderURL: URL?,
        outputFolderURL: URL?
    ) -> [URL] {
        var list = [URL]()
        if let inputFolderURL {
            list.append(inputFolderURL)
        }
        if let outputFolderURL {
            try? outputFolderURL.subDirectories().forEach { url in
                list.append(url)
            }
            
        }
        return list
    }
}

//extension DotLottieCreator {
//    func create() async -> URL? {
//        await withCheckedContinuation { continuation in
//            self.create { url in
//                continuation.resume(with: .success(url))
//            }
//        }
//    }
//}

//extension LottieConverter {
//    static let temporaryDirectory = FileManager.default.temporaryDirectory
//    
//    static var animationsDirectory: URL {
//        temporaryDirectory.appendingPathComponent("animations")
//    }
//    
//    static var manifestFileURL: URL {
//        temporaryDirectory.appendingPathComponent("manifest").appendingPathExtension("json")
//    }
//    
//    static let dotLottieExtension = "lottie"
//    
//}
//
//struct LottieConverter {
//    static func convert(
//        files: [URL],
//        outputFolder: URL,
//        color: String = "#ffffff",
//        noLoop: Bool = false
//    ) async throws {
//        for file in files {
//
//            try await convert(
//                file: file,
//                output: outputFolder,
//                themeColor: color,
//                loop: !noLoop
//            )
//        }
//    }
//    
//    static func copyItem(_ item: URL) throws {
//        let destinationURL = animationsDirectory.appendingPathComponent(item.lastPathComponent)
//        try? FileManager.default.removeItem(at: destinationURL)
//        try FileManager.default.copyItem(at: item, to: destinationURL)
//    }
//    
//    static func createAnimationsDirectory() throws {
//        try FileManager.default.createDirectory(
//            at: animationsDirectory,
//            withIntermediateDirectories: true,
//            attributes: nil
//        )
//    }
//    
//    static func convert(
//        file: URL,
//        output: URL,
//        themeColor: String = "#ffffff",
//        loop: Bool = true
//    ) async throws {
//        try createAnimationsDirectory()
//        try copyItem(file)
//        let filename = file.deletingPathExtension().lastPathComponent
//        try await createManifest(
//            fileName: filename,
//            themeColor: themeColor,
//            loop: loop
//        )
//        Zip.addCustomFileExtension(dotLottieExtension)
//        try Zip.zipFiles(
//            paths: [
//                animationsDirectory,
//                manifestFileURL
//            ],
//            zipFilePath: output.appendingPathComponent(filename).appendingPathExtension(dotLottieExtension),
//            password: nil,
//            compression: .DefaultCompression,
//            progress: { progress in
//                debugPrint("Compressing file: \(progress)")
//            }
//        )
//    }
//    
//    static func workingconvert(
//        file: URL,
//        output: URL,
//        themeColor: String = "#ffffff",
//        loop: Bool = true
//    ) async throws {
//        try FileManager.default.createDirectory(at: output.appendingPathComponent(file.deletingPathExtension().lastPathComponent), withIntermediateDirectories: true, attributes: nil)
//        try FileManager.default.createDirectory(at: output.appendingPathComponent(file.deletingPathExtension().lastPathComponent).appendingPathComponent("animations"), withIntermediateDirectories: true, attributes: nil)
//        try FileManager.default.copyItem(at: file, to: output.appendingPathComponent(file.deletingPathExtension().lastPathComponent).appendingPathComponent("animations").appendingPathComponent("zstart").appendingPathExtension("json"))
//        let manifestUrl = output.appendingPathComponent(file.deletingPathExtension().lastPathComponent).appendingPathComponent("manifest").appendingPathExtension("json")
//        try await createManifest(
//            fileName: file.deletingPathExtension().lastPathComponent,
//            themeColor: themeColor,
//            loop: loop
//        )
//        Zip.addCustomFileExtension("lottie")
//        try Zip.zipFiles(
//            paths: [
//                output.appendingPathComponent(file.deletingPathExtension().lastPathComponent).appendingPathComponent("animations"),
//                manifestUrl
//            ],
//            zipFilePath: output.appendingPathComponent(file.deletingPathExtension().lastPathComponent).appendingPathExtension("lottie"),
//            password: nil,
//            compression: .DefaultCompression,
//            progress: { progress in
//                debugPrint("Compressing file: \(progress)")
//            }
//        )
//    }
//    
//    private static func createManifest(
//        fileName: String,
//        themeColor: String = "#ffffff",
//        loop: Bool = true
//    ) async throws {
//        let manifest = LottieManifest(
//            animations: [
//                LottieAnimation(
//                    id: fileName,
//                    loop: loop,
//                    themeColor: themeColor,
//                    speed: 1.0
//                )
//            ],
//            version: "1.0",
//            author: "LottieFiles",
//            generator: "LottieFiles - Delivery Hero SE"
//        )
//        
//        let manifestData = try manifest.encode()
//        try manifestData.write(to: manifestFileURL)
//    }
//}
//
//private enum ConverterError: Error {
//    case fileNotDecoded(url: URL)
//    case fileNotSupported
//}

//struct Converter: AsyncParsableCommand {
//    static let configuration: CommandConfiguration = CommandConfiguration(
//        abstract: "dotLottie converter is a command-line tool that converts Lottie JSON files to dotLottie files using the dotLottieLoader library.",
//        usage: "dotLottieConverter <lottie files – lottiefiles/*.json> --output <output folder>] [--verbose]"
//    )
//
//    @Argument(
//        help: "List of Lottie JSON files to be converted to dotLottie.",
//        transform: URL.init(fileURLWithPath:)
//    )
//    private var files: [URL]
//
//    @Option(name: .shortAndLong, help: ArgumentHelp(
//        "Output folder",
//        discussion: "Will be created in case it does not exist. If not provided files will be saved to temp folder."
//    ), transform: URL.init(fileURLWithPath:))
//    private var output: URL?
//
//    @Option(name: .shortAndLong, help: "Theme color.")
//    private var color: String = "#ffffff"
//
//    @Flag(name: .shortAndLong, help: "Creates file with looping disabled.")
//    private var noLoop: Bool = false
//
//    @Flag(name: .shortAndLong, help: "Will print paths to all created dotLottie files.")
//    private var verbose: Bool = false
//
//    func run() async throws {
//        for file in files {
//
//            var creator = DotLottieCreator(animationUrl: file)
//            creator.loop = !noLoop
//            creator.themeColor = color
//            if let output = output {
//                creator.directory = output
//            }
//
//            let result = await creator.create()
//
//            guard let result = result else {
//                throw ConverterError.fileNotDecoded(url: file)
//            }
//
//            if verbose {
//                print(result)
//            }
//        }
//    }
//}
