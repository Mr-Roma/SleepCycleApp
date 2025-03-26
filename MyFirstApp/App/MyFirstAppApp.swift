//
//  MyFirstAppApp.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

import SwiftUI

@main
struct MyFirstAppApp: App {
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                          OnboardingView(isFirstLaunch: $isFirstLaunch)
                      } else {
                          ContentView()
                      }
        }
    }
}


#Preview {
    ContentView()
}
