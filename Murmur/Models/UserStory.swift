//
//  UserStory.swift
//  Murmur
//
//  Created by Muchan Kim on 6/28/25.
//

import Foundation
import SwiftData


@Model

class UserStory: Identifiable {
    var id = UUID()
    var createdAt: Date
    var content: String
    var emotionKeywords: [String]
    var recommendedSongAuthor: String
    var recommendedSongTitle: String
    
    
    init(id: UUID = UUID(), createdAt: Date, content: String, emotionKeywords: [String], recommendedSongAuthor: String, recommendedSongTitle: String) {
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

//관계선언이 필요할 수 있다
// 두 개의 데이터가 연관이 있는지 없는지 판단해야될듯


