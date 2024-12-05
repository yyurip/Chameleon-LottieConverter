//
//  BrandsContainer.swift
//  Chameleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 29.11.24.
//

import Foundation
import SwiftData

actor BrandsContainer {
    @MainActor
    static func create(shouldAddDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Brand.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: configuration)
        if shouldAddDefaults {
            Brand.defaults.forEach { brand in
                container.mainContext.insert(brand)
                shouldAddDefaults = false
            }
        }
        return container
    }
}
