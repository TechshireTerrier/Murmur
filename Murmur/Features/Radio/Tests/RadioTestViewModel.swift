//  TestViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 6/29/25.
//

import Foundation
import CoreML

final class RadioTestViewModel: ObservableObject {
    @Published var currentStory: UserStory
    @Published var generatedScript: RadioScript?
    @Published var subtitleSegments: [SubtitleSegment] = []
    @Published var currentSubtitle: String = ""
    @Published var isPlaying: Bool = false
    
    // --- 키워드 추출 관련 프로퍼티 추가 ---
    @Published var sentenceKeywords: [(sentence: String, keyword: String)] = []
    private let predictor = ScriptKeywordPredictor()
    // --- 끝 ---
    
    private let sessionManager: RadioSessionManager
    
    init(sessionManager: RadioSessionManager = RadioSessionManager()) {
        self.sessionManager = sessionManager
        self.currentStory = MockData.sampleStory
        
        loadInitialData()
    }
    
    func playButtonTapped() {
        if isPlaying {
            stopPlay()
        } else {
            startPlaying()
        }
    }
    
    func refreshData() {
        if isPlaying {
            stopPlay()
        }
        loadInitialData()
    }
    
    func changeStory(_ newStory: UserStory) {
        if isPlaying {
            stopPlay()
        }
        currentStory = newStory
        loadInitialData()
    }
    
    private func loadInitialData() {
        generatedScript = sessionManager.generateScript(from: currentStory)
        
        if let script = generatedScript {
            subtitleSegments = sessionManager.generateSubtitleSegments(from: script)
        }
    }
    
    private func startPlaying() {
        guard !subtitleSegments.isEmpty else { return }
        
        isPlaying = true
        
        sessionManager.play(
            segments: subtitleSegments,
            onSubtitleChange: { [weak self] subtitle in
                DispatchQueue.main.async {
                    self?.currentSubtitle = subtitle
                }
            },
            complete: { [weak self] in
                DispatchQueue.main.async {
                    self?.isPlaying = false
                    self?.currentSubtitle = ""
                }
            }
        )
    }
    
    private func stopPlay() {
        sessionManager.stop()
        
        isPlaying = false
        currentSubtitle = ""
    }
    
    // --- 키워드 추출 함수 추가 ---
    func extractKeywordsFromScript() {
        guard let script = generatedScript else { return }
        let sentences = splitScriptIntoSentences(script.fullScript)
        sentenceKeywords = sentences.compactMap { sentence in
            if let keyword = predictor.predictKeyword(for: sentence) {
                return (sentence, keyword)
            } else {
                return nil
            }
        }
    }
    
    private func splitScriptIntoSentences(_ script: String) -> [String] {
        // 마침표, 물음표, 느낌표 등으로 분리 (간단 예시)
        let separators = CharacterSet(charactersIn: ".!?")
        let sentences = script.components(separatedBy: separators)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        return sentences
    }
    // --- 끝 ---
}

final class ScriptKeywordPredictor {
    private let model = MurmurTextClassifier()
    
    func predictKeyword(for sentence: String) -> String? {
        do {
            let prediction = try model.prediction(text: sentence)
            return prediction.label
        } catch {
            print("Prediction failed: \(error)")
            return nil
        }
    }
}
