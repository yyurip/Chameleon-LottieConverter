//
//  CharmeleonApp.swift
//  Charmeleon
//
//  Created by Ygor Yuri De Pinho Pessoa on 15.11.24.
//

import SwiftUI
import SwiftData

@main
struct LottieColorizerMacOSAppApp: App {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    @AppStorage("isDarkModeSelected") private var isDarkModeSelected: Bool = true

        var appearanceSwitch: ColorScheme? {
            return isDarkModeSelected ? .dark : .light
        }
    
    var body: some Scene {
        WindowGroup {
            ColorizeView()
                .frame(minWidth: 400, maxWidth: 800)
                .preferredColorScheme(appearanceSwitch)
                .modelContainer(
                    BrandsContainer.create(
                        shouldAddDefaults: &isFirstTimeLaunch
                    )
                )
        }
        .windowResizability(.contentSize)
    }
}
