//
//  UserStory.swift
//  Murmur
//
//  Created by Muchan Kim on 6/28/25.
//

import Foundation
import SwiftData

@Model
final class UserStory {
    var id: UUID
    var createdAt: Date
    var content: String
    var emotionKeywords: [String]
    var recommendedSongAuthor: String
    var recommendedSongTitle: String

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        content: String,
        emotionKeywords: [String] = [],
        recommendedSongAuthor: String = "",
        recommendedSongTitle: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.emotionKeywords = emotionKeywords
        self.recommendedSongAuthor = recommendedSongAuthor
        self.recommendedSongTitle = recommendedSongTitle
    }
}

struct RadioScript {
    let fullScript: String
}

struct SubtitleSegment {
    let text: String
    let originalRange: NSRange
}

