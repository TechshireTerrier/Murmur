//
//  MurmurApp.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftUI
import SwiftData

@main
struct MurmurApp: App {
    @StateObject private var navigationManager = NavigationManager()
    @Environment(\.modelContext) private var modelContext

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                HomeView()
                    .navigationDestination(for: DestinationType.self) { destination in
                        ViewRouter(for: destination, modelContext: modelContext)
                    }
            }
            .preferredColorScheme(.dark)
            .environmentObject(navigationManager)
        }
        .modelContainer(for: [Story.self, UserStory.self])
    }
}
