//
//  RadioTestViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 8/10/25.
//

import Foundation

@MainActor
final class RadioViewModel: ObservableObject {
    @Published var currentStory: UserStory
    @Published var generatedScript: RadioScript?
    @Published var isPlaying: Bool = false
    @Published var currentSubtitle: String = ""

    private let sessionManager: RadioSessionManager
    private var subtitleSegments: [SubtitleSegment] = []
    
    init(sessionManager: RadioSessionManager = RadioSessionManager()) {
        self.sessionManager = sessionManager
        self.currentStory = MockData.sampleStory
        
        loadInitialData()
    }
    
    func startPlaying() {
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
    
    func stopPlaying() {
        sessionManager.stop()
        
        isPlaying = false
        currentSubtitle = ""
    }
        
    private func loadInitialData() {
        generatedScript = sessionManager.generateScript(from: currentStory)
        
        if let script = generatedScript {
            subtitleSegments = sessionManager.generateSubtitleSegments(from: script)
        }
    }
}
