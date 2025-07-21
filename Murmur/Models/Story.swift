//
//  Story.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import Foundation
import SwiftData

// TODO: - 임시
@Model
final class Story {
    var id: UUID
    var createdAt: Date
    var content: String
    var recommendedSongAuthor: String
    var recommendedSongTitle: String
    
    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        content: String,
        recommendedSongAuthor: String = "",
        recommendedSongTitle: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.recommendedSongAuthor = recommendedSongAuthor
        self.recommendedSongTitle = recommendedSongTitle
    }
}
