//
//  TestViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 6/29/25.
//

import Foundation

final class RadioTestViewModel: ObservableObject {
    @Published var currentStory: UserStory
    @Published var generatedScript: RadioScript?
    @Published var subtitleSegments: [SubtitleSegment] = []
    @Published var currentSubtitle: String = ""
    @Published var isPlaying: Bool = false
    
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
}
