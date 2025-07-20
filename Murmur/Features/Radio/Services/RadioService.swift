//
//  RadioService.swift
//  Murmur
//
//  Created by Muchan Kim on 6/29/25.
//

// 해당 프로토콜 네이밍 수정 필요.
protocol RadioService {
    func generateScript(from story: UserStory) -> RadioScript
}

protocol SubtitleService {
    func generateSegments(from script: RadioScript) -> [SubtitleSegment]
}

protocol TTSService {
    func speak(_ text: String, completion: @escaping () -> Void)
    func stop()
}
