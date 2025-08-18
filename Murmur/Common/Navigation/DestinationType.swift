//
//  DestinationType.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//

import SwiftData
import SwiftUI

enum DestinationType: Hashable {
    // Home
    case home

    // Story
    case writeStory // 사연신청뷰
    case totalStoryList // 전체 사연 목록
    case detailStory(story: Story) // 사연 상세
    case modifyStory(story: Story) // 사연 수정
    case radio // 라디오

    // etc
    case loading(story: Story) // 로딩 화면
}

@ViewBuilder
func ViewRouter(for destination: DestinationType, modelContext: ModelContext) -> some View {
    switch destination {
    case .home:
        HomeView()
    case .writeStory:
        WriteView(modelContext: modelContext)
    case .totalStoryList:
        TotalStoryListView(modelContext: modelContext)
    case let .detailStory(story):
        DetailStoryView(story: story)
    case let .modifyStory(story):
        ModifyStoryView(story: story)
    case .radio:
        RadioView()
    case let .loading(story):
        LoadingView(story: story)
    }
}
