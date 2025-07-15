//
//  TTSServiceImpl.swift
//  Murmur
//
//  Created by Moo on 7/13/25.
//

import AVFoundation
import Foundation

// @unchecked 사용은 좋지않지만 추후 개선하겠습니다.
final class TTSServiceImpl: NSObject, TTSService, @unchecked Sendable {
    private let synthesizer = AVSpeechSynthesizer()
    private var completion: (() -> Void)?
    private let voiceSpeed: Float = 0.45
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(_ text: String, completion: @escaping () -> Void) {
        if synthesizer.isSpeaking {
            stop()
        }
        
        self.completion = completion
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = voiceSpeed
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        completion = nil
    }
}

extension TTSServiceImpl: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        completion?()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        completion = nil
    }
}
