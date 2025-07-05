//
//  MurmurApp.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftUI

@main
struct MurmurApp: App {
    @StateObject private var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                HomeView()
                    .navigationDestination(for: DestinationType.self) { destination in
                        ViewRouter(for: destination)
                    }
            }
            .preferredColorScheme(.dark)
            .environmentObject(navigationManager)
        }
    }
}
