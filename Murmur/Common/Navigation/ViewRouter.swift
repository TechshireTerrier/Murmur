//
//  ViewRouter.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//

import SwiftUI

@ViewBuilder
func ViewRouter(for destination: DestinationType) -> some View {
    switch destination {
    case .home:
        HomeView()
    case .writeStory:
        WriteView()
    case .sttStory:
        // TODO: - STT 사연 신청 뷰 구현
        EmptyView()
    case .sttConfirm:
        // TODO: - STT 사연 신청 확인 뷰 구현
        EmptyView()
    case .totalStoryList:
        TotalStoryListView()
    case .detailStory:
        SongView()
    case .modifyStory:
        // TODO: - 사연 수정 뷰 구현
        EmptyView()
    case .radio:
        // TODO: - 라디오듣기 뷰 구현
        RadioTestView()
    }
}
