//
//  DestinationType.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//

import Foundation

enum DestinationType: Hashable {
    // Home
    case home

    // Story
    case writeStory // 사연신청뷰
    case sttStory // 사연신청 (STT)
    case sttConfirm // 사연신청 (STT) 확인
    case totalStoryList // 전체 사연 목록
    case detailStory(story: Story) // 사연 상세
    case modifyStory // 사연 수정
    case radio(story: Story) // 라디오

    // etc
    case loading(story: Story) // 로딩 화면
}
