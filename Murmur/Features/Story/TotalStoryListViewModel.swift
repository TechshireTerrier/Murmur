//
//  TotalStoryListViewModel.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import SwiftData
import SwiftUI

class TotalStoryListViewModel: ObservableObject {
    @Published var stories: [Story] = []
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchStoriesFromSwiftData()
    }

    func fetchStoriesFromSwiftData() {
        print("Fetching stories from SwiftData...")
        do {
            let descriptor = FetchDescriptor<Story>(
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
            stories = try modelContext.fetch(descriptor)
            print("Successfully fetched \(stories.count) stories")
            for (index, story) in stories.enumerated() {
                print("Story \(index + 1): ID=\(story.id), created=\(story.createdAt), content=\(String(story.content.prefix(50)))...")
            }
        } catch {
            print("Failed to fetch stories: \(error)")
            stories = []
        }
    }

    func refreshStories() {
        fetchStoriesFromSwiftData()
    }
    
    func getRandomStory() -> Story? {
        guard !stories.isEmpty else { return nil }
        return stories.randomElement()
    }
}
