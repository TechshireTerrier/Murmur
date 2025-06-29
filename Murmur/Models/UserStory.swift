//
//  UserStory.swift
//  Murmur
//
//  Created by Muchan Kim on 6/28/25.
//

import Foundation

struct UserStory: Identifiable {
    let id = UUID()
    let createdAt: Date
    let content: String
    let emotionKeywords: [String]
    let recommendedSongAuthor: String
    let recommendedSongTitle: String
}

struct RadioScript {
    let fullScript: String
}
