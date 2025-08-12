//
//  DetailStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct DetailStoryView: View {
    @StateObject private var viewModel: DetailStoryViewModel
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel
    @EnvironmentObject private var navigationManager: NavigationManager

    init(story: Story) {
        _viewModel = StateObject(wrappedValue: DetailStoryViewModel(story: story))
    }

    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    SongStoryView(story: viewModel.story)
                    DailyEmotionView(emotions: viewModel.emotions, isLoading: viewModel.isLoadingEmotions)
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
