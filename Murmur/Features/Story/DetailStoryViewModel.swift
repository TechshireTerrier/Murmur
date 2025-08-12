//
//  DetailStoryViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 8/12/25.
//

import Foundation
import SwiftData

@MainActor
final class DetailStoryViewModel: ObservableObject {
    @Published var story: Story
    @Published var emotions: [EmotionResult] = []
    @Published var isLoadingEmotions = false
    
    private let emotionService = EmotionAnalysisService()
    private var modelContext: ModelContext?
    
    init(story: Story, modelContext: ModelContext? = nil) {
        self.story = story
        self.modelContext = modelContext
        
        // Story에 이미 감정 데이터가 있으면 사용, 없으면 분석 시작
        if !story.emotions.isEmpty {
            self.emotions = story.emotions.map { EmotionResult(label: $0, confidence: 1.0) }
        } else {
            analyzeEmotions()
        }
    }
    
    private func analyzeEmotions() {
        isLoadingEmotions = true
        print("🔍 Starting emotion analysis...")
        
        Task {
            let analyzedEmotions = emotionService.analyzeEmotions(from: story.content)
            
            await MainActor.run {
                self.emotions = analyzedEmotions
                self.isLoadingEmotions = false
                
                // Story 모델에 감정 데이터 저장
                let emotionLabels = analyzedEmotions.map { $0.label }
                self.story.emotions = emotionLabels
                
                // SwiftData에 저장
                if let modelContext = self.modelContext {
                    do {
                        try modelContext.save()
                        print("✅ Emotion analysis completed and saved: \(analyzedEmotions.count) emotions")
                    } catch {
                        print("❌ Failed to save emotions to SwiftData: \(error)")
                    }
                }
            }
        }
    }
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
}
