//
//  MurmurApp.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftData
import SwiftUI

@main
struct MurmurApp: App {
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var musicRecommendationVM = MusicRecommendationViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Story.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                HomeView()
                    .navigationDestination(for: DestinationType.self) { destination in
                        ViewRouter(for: destination, modelContext: sharedModelContainer.mainContext)
                    }
            }
            .preferredColorScheme(.dark)
            .environmentObject(navigationManager)
            .environmentObject(musicRecommendationVM)
            .task {
                await musicRecommendationVM.requestMusicAuthorization()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
