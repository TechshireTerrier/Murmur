//
//  Story.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import Foundation

// TODO: - 임시
struct Story: Identifiable {
    let id = UUID()
    let createdAt: Date
    let content: String
    let recommendedSongAuthor: String
    let recommendedSongTitle: String
}
