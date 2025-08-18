//
//  LoadingView.swift
//  Murmur
//
//  Created by gabi on 7/7/25.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel
    @StateObject private var emotionAnalysisService = EmotionAnalysisService()

    @State var story: Story

    init(story: Story) {
        _story = State(initialValue: story)
    }

    var body: some View {
        if musicRecommendationVM.isMusicAuthorized {
            VStack {
                Image(systemName: "music.quarternote.3")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.keyMint)
                    .accessibilityLabel("음표들")
                    .accessibilityAddTraits(.isImage)
                    .padding()

                Text("사연에 딱 맞는\n곡을 고르는 중이에요")
                    .multilineTextAlignment(.center)
                    .font(.PretendardTitle2Bold)
                    .accessibilityLabel("사연에 딱 맞는 곡을 고르는 중이에요")
                    .accessibilityAddTraits(.isStaticText)
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                Task {
                    story.emotions = EmotionAnalysisService().analyzeEmotions(from: story.content).map { $0.label }
                    guard let searchTerm = story.emotions.first else {
                        // 감정이 없을 경우 기본 메시지 표시
                        print("감정이 없습니다.")
                        navigationManager.pop()
                        return
                    }
                    await musicRecommendationVM.searchAndRecommendSong(searchTerm: story.emotions[0])
                }
            }
            .onChange(of: musicRecommendationVM.recommendedTrack) { newValue in
                if newValue != nil {
                    // story를 DetailStoryView에 전달
                    navigationManager.push(to: .detailStory(story: story))
                }
            }
        } else {
            Text("음악 추천을 받으려면 Apple Music 접근 권한이 필요합니다.")
            Button("권한 요청하기") {
                Task {
                    await musicRecommendationVM.requestMusicAuthorization()
                }
            }
        }
    }
}

#Preview {
    LoadingView(story: MockData.sampleStory)
}
