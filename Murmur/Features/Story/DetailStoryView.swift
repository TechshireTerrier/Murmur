//
//  DetailStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct DetailStoryView: View {
//    @StateObject private var viewModel: DetailStoryViewModel
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let story: Story

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
        .enableSwipeBack()
        .toolbar {
            CustomBackButton {
                navigationManager.pop()
            }
        }
        .onDisappear {
            musicRecommendationVM.stopPlayback()
        }
    }
}

#Preview {
    DetailStoryView(story: MockData.sampleStory)
        .environmentObject(MusicRecommendationViewModel())
}
