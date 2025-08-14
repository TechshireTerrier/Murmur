//
//  ViewRouter.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//
import SwiftData
import SwiftUI

@ViewBuilder
func ViewRouter(for destination: DestinationType, modelContext: ModelContext) -> some View {
    switch destination {
    case .home:
        HomeView()
    case .writeStory:
        WriteView(modelContext: modelContext)
    case .sttStory:
        // TODO: - STT 사연 신청 뷰 구현
        EmptyView()
    case .sttConfirm:
        // TODO: - STT 사연 신청 확인 뷰 구현
        EmptyView()
    case .totalStoryList:
        TotalStoryListView(modelContext: modelContext)
    case let .detailStory(story):
        DetailStoryView(story: story)
    case .modifyStory:
        // TODO: - 사연 수정 뷰 구현
        EmptyView()
    case .radio:
        // TODO: - 라디오듣기 뷰 구현
        RadioView()
    case let .loading(story):
        LoadingView(story: story)
    }
}
