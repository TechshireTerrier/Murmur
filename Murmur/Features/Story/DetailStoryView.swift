//
//  DetailStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftData
import SwiftUI

struct DetailStoryView: View {
//    @StateObject private var viewModel: DetailStoryViewModel
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel
    @EnvironmentObject private var navigationManager: NavigationManager

    let story: Story
    @Environment(\.modelContext) private var modelContext

    init(story: Story) {
//        _viewModel = StateObject(wrappedValue: DetailStoryViewModel(story: story))
        self.story = story
    }

    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    SongStoryView(story: story)
                    DailyEmotionView(emotions: story.emotions)
                    StoryMusicView(musicRecommendationVM: musicRecommendationVM)
                }
                DetailStoryButtonView()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            updateStoryWithRecommendedSong()
            // ViewModel에 modelContext 설정
//            viewModel.setModelContext(modelContext)
        }
        .onDisappear {
            musicRecommendationVM.stopPlayback()
        }
    }

    private func updateStoryWithRecommendedSong() {
        // 추천된 노래가 있고, Story에 아직 노래 정보가 없는 경우에만 업데이트
        if let recommendedTrack = musicRecommendationVM.recommendedTrack,
           story.recommendedSongTitle.isEmpty
        {
            // Story 객체에 노래 정보 업데이트sef
            story.recommendedSongTitle = recommendedTrack.title
            story.recommendedSongAuthor = recommendedTrack.artistName

            // SwiftData에 변경사항 저장
            do {
                try modelContext.save()
                print("Story updated with song: \(recommendedTrack.title) by \(recommendedTrack.artistName)")
            } catch {
                print("Failed to update story with song info: \(error)")
            }
        }
    }
}

#Preview {
    DetailStoryView(story: MockData.sampleStory)
        .environmentObject(MusicRecommendationViewModel())
}
