//
//  RadioService.swift
//  Murmur
//
//  Created by Muchan Kim on 6/29/25.
//

protocol RadioService {
    func generateScript(from story: UserStory) -> RadioScript
    // func convertTTS(from script: RadioScript) -> AudioData
    // func generateSubtitles(from script: RadioScript) -> [Subtitle]
}
