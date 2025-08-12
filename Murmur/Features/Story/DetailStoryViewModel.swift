//
//  DetailStoryViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 8/12/25.
//

import Foundation

@MainActor
final class DetailStoryViewModel: ObservableObject {
    @Published var story: Story
    @Published var emotions: [EmotionResult] = []
    @Published var isLoadingEmotions = false
    
    private let emotionService = EmotionAnalysisService()
    
    init(story: Story) {
        self.story = story
        analyzeEmotions()
    }
    
    private func analyzeEmotions() {
        isLoadingEmotions = true
        print("🔍 Starting emotion analysis...")
        
        Task {
            let analyzedEmotions = emotionService.analyzeEmotions(from: story.content)
            
            await MainActor.run {
                self.emotions = analyzedEmotions
                self.isLoadingEmotions = false
                print("✅ Emotion analysis completed: \(analyzedEmotions.count) emotions")
            }
        }
    }
}
