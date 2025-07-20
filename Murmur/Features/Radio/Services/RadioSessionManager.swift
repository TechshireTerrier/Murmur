//
//  RadioSessionManager.swift
//  Murmur
//
//  Created by Moo on 7/13/25.
//

import SwiftUI

class RadioSessionManager {
    private let radioService: RadioService
    private let subtitleService: SubtitleService
    private let ttsService: TTSService
    
    private var segments: [SubtitleSegment] = []
    private var currentIndex = 0
    private var isCurrentlyPlaying = false
    private var currentSegmentText = ""
    
    private var onSubtitleChangeCallback: ((String) -> Void)?
    private var onCompleteCallback: (() -> Void)?
    
    private var subtitleTimer: Timer?
    
    init(
        radioService: RadioService = RadioServiceImpl(),
        subtitleService: SubtitleService = SubtitleServiceImpl(),
        ttsService: TTSService = TTSServiceImpl()
    ) {
        self.radioService = radioService
        self.subtitleService = subtitleService
        self.ttsService = ttsService
    }
    
    func generateScript(from story: UserStory) -> RadioScript {
        return radioService.generateScript(from: story)
    }
    
    func generateSubtitleSegments(from script: RadioScript) -> [SubtitleSegment] {
        return subtitleService.generateSegments(from: script)
    }
    
    func play(segments: [SubtitleSegment], onSubtitleChange: @escaping (String) -> Void, complete: @escaping () -> Void) {
        if isCurrentlyPlaying {
            stop()
        }
        
        self.segments = segments
        self.currentIndex = 0
        self.isCurrentlyPlaying = true
        self.onSubtitleChangeCallback = onSubtitleChange
        self.onCompleteCallback = complete
        
        playCurrentSegment()
    }
    
    func stop() {
        ttsService.stop()
        
        subtitleTimer?.invalidate()
        subtitleTimer = nil
        
        isCurrentlyPlaying = false
        currentIndex = 0
        currentSegmentText = ""
        segments = []
        
        onSubtitleChangeCallback = nil
        onCompleteCallback = nil
    }
    
    func getState() -> (isPlaying: Bool, currentSubtitle: String) {
        return (isCurrentlyPlaying, currentSegmentText)
    }
    
    private func playCurrentSegment() {
        guard isCurrentlyPlaying else { return }
        
        guard currentIndex < segments.count else {
            isCurrentlyPlaying = false
            let completeCallback = onCompleteCallback
            onCompleteCallback = nil
            onSubtitleChangeCallback = nil
            completeCallback?()
            return
        }
        
        let segment = segments[currentIndex]
        currentSegmentText = segment.text
        
        onSubtitleChangeCallback?(segment.text)
        
        let estimatedDuration = calculateDuration(for: segment.text)
        let subtitleChangeTime = estimatedDuration * 0.85
        
        if currentIndex + 1 < segments.count {
            subtitleTimer = Timer.scheduledTimer(withTimeInterval: subtitleChangeTime, repeats: false) { [weak self] _ in
                guard let self = self, self.isCurrentlyPlaying else { return }
                
                if self.currentIndex + 1 < self.segments.count {
                    let nextSegment = self.segments[self.currentIndex + 1]
                    self.onSubtitleChangeCallback?(nextSegment.text)
                }
            }
        }
        
        ttsService.speak(segment.text) { [weak self] in
            guard let self = self, self.isCurrentlyPlaying else { return }
            
            self.subtitleTimer?.invalidate()
            self.subtitleTimer = nil
            
            self.currentIndex += 1
            self.playCurrentSegment()
        }
    }
    
    private func calculateDuration(for text: String) -> TimeInterval {
        let baseRate = 2.5
        let characterCount = Double(text.count)
        let baseDuration = characterCount / baseRate
        
        let pauseTime = Double(text.components(separatedBy: CharacterSet(charactersIn: ".!?")).count - 1) * 0.3
        
        return baseDuration + pauseTime
    }
}
