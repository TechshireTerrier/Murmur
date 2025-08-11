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
    @StateObject private var musicRecommendationVM = MusicRecommendationViewModel()

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
            .environmentObject(musicRecommendationVM)
            .task {
                await musicRecommendationVM.requestMusicAuthorization()
            }
        }
        .modelContainer(for: [Story.self, UserStory.self])
    }
}
