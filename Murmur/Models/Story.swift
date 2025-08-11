//
//  Story.swift
//  Murmur
//
//  Created by Muchan Kim on 6/28/25.
//

import Foundation
import SwiftData

@Model
final class Story {
    var id: UUID
    var createdAt: Date
    var content: String
    var emotions: [String]
    var recommendedSongAuthor: String
    var recommendedSongTitle: String

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        content: String,
        emotions: [String] = [],
        recommendedSongAuthor: String = "",
        recommendedSongTitle: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.emotions = emotions
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
