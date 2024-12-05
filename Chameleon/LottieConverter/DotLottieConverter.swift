//////
//////  LottieCreator.swift
//////  Chameleon
//////
//////  Created by Ygor Yuri De Pinho Pessoa on 04.12.24.
//////
////
//import Foundation
//import Zip
////
/////// Configuration model
//public struct DotLottieConverter {
//    /// URL to main animation JSON file
//    public var url: URL
//    
//    /// Loop enabled - Default true
//    public var loop: Bool = true
//    
//    /// appearance color in HEX - Default #ffffff
//    public var themeColor: String = "#ffffff"
//       
//    /// URL to directory where we are saving the files
//    public var directory: URL
//    
//    public init(animationUrl: URL, directory: URL) {
//        url = animationUrl
//        self.directory = directory
//    }
//    
//    /// directory for dotLottie
//    private var dotLottieDirectory: URL {
//        directory.appendingPathComponent(fileName)
//    }
//    
//    /// Animations directory
//    private var animationsDirectory: URL {
//        dotLottieDirectory.appendingPathComponent("animations")
//    }
//    
//    /// checks if is a lottie file
////    private var isLottie: Bool {
////        url.isJsonFile
////    }
//    
//    /// Filename
//    private var fileName: String {
//        url.deletingPathExtension().lastPathComponent
//    }
//    
//    /// URL for main animation
//    private var animationUrl: URL {
//        animationsDirectory.appendingPathComponent(fileName).appendingPathExtension("json")
//    }
//    
//    /// URL for manifest file
//    private var manifestUrl: URL {
//        dotLottieDirectory.appendingPathComponent("manifest").appendingPathExtension("json")
//    }
//    
//    /// URL for output
//    private var outputUrl: URL {
//        directory.appendingPathComponent(fileName).appendingPathExtension("lottie")
//    }
////    
////    /// Downloads file from URL and returns local URL
////    /// - Parameters:
////    ///   - url: Remote file URL
////    ///   - saveUrl: Local file URL to persist
////    ///   - completion: Local URL
//    private static func download(from url: URL, to saveUrl: URL, completion: @escaping (Bool) -> Void) {
//        /// file is not remote, save the animation content to the proper same URL and return
////        guard url.isRemoteFile else {
//            let animationData = try? Data(contentsOf: url)
//            do {
//                try animationData?.write(to: saveUrl)
//                completion(true)
//                return
//            } catch {
//                debugPrint("Failed to save animation data: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
////        }
//        
////        debugPrint("Downloading from url: \(url.path)")
////        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
////            guard let data = data else {
////                debugPrint("Failed to download data: \(error?.localizedDescription ?? "no description")")
////                completion(false)
////                return
////            }
////            
////            do {
////                try data.write(to: saveUrl)
////                completion(true)
////            } catch {
////                debugPrint("Failed to save downloaded data: \(error.localizedDescription)")
////                completion(false)
////            }
////        }).resume()
//    }
////    
//    /// Creates folders File
//    /// - Throws: Error
//    private func createFolders() throws {
//        try FileManager.default.createDirectory(at: dotLottieDirectory, withIntermediateDirectories: true, attributes: nil)
//        try FileManager.default.createDirectory(at: animationsDirectory, withIntermediateDirectories: true, attributes: nil)
//    }
//    
////    /// Creates main animation File
//    private func createAnimation(completion: @escaping (Bool) -> Void) {
//        Self.download(from: url, to: animationUrl, completion: completion)
//    }
//    
//    /// Creates manifest File
//    /// - Throws: Error
//    private func createManifest(
//        completed: @escaping (Bool) -> Void) {
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
//        do {
//            let manifestData = try manifest.encode()
//            try manifestData.write(to: manifestUrl)
//            completed(true)
//        } catch {
//            completed(false)
//        }
//    }
//    
//    
//    
//    /// Creates dotLottieFile with given configurations
//    /// - Parameters:
//    ///   - configuration: configuration for DotLottie file
//    /// - Returns: URL of .lottie file
//    public func create(
//        file:URL,
//        completion: @escaping (URL?) -> Void) {
////        guard isLottie else {
////            DotLottieUtils.log("Not a json file")
////            completion(nil)
////            return
////        }
//        
//        do {
//            try createFolders()
//            createAnimation { success in
//                guard success else { return }
//                
//                createManifest { success in
//                    guard success else { return }
//                    
//                    do {
//                        Zip.addCustomFileExtension("lottie")
//                        try Zip.zipFiles(paths: [animationsDirectory, manifestUrl], zipFilePath: outputUrl, password: nil, compression: .DefaultCompression, progress: { progress in
//                            debugPrint("Compressing dotLottie file: \(progress)")
//                        })
//                        
//                        debugPrint("Created dotLottie file at \(outputUrl)")
//                        completion(outputUrl)
//                    } catch {
//                        completion(nil)
//                    }
//                }
//            }
//        } catch {
////            DotLottieUtils.log("Failed to create dotLottie file \(error)")
//            completion(nil)
//        }
//    }
//    
////    public func convert(
////        lottieURL: URL
////    ) async throws -> URL? {
////        guard isLottie else {
////            DotLottieUtils.log("Not a json file")
//////            completion(nil)
////            throw ConverterError.fileNotSupported
////            return
////        }
////        
//////        do {
//////            try createFolders()
//////            createAnimation { success in
//////                guard success else { return }
//////                
//////                createManifest { success in
//////                    guard success else { return }
//////                    
////                    
////        try createManifest()
////        Zip.addCustomFileExtension("lottie")
////        try Zip.zipFiles(
////            paths: [animationsDirectory, manifestUrl],
////            zipFilePath: outputUrl,
////            password: nil,
////            compression: .DefaultCompression,
////            progress: { progress in
////                debugPrint("Compressing dotLottie file: \(progress)")
////            }
////        )
////            
//////                        DotLottieUtils.log("Created dotLottie file at \(outputUrl)")
////            return outputUrl
//////                }
//////            }
//////        } catch {
//////            DotLottieUtils.log("Failed to create dotLottie file \(error)")
//////            completion(nil)
//////        }
////    }
//}
//
//
