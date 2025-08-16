//
//  DetailStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI
import SwiftData

struct DetailStoryView: View {
    @StateObject private var viewModel: DetailStoryViewModel
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel
    @EnvironmentObject private var navigationManager: NavigationManager
    @Environment(\.modelContext) private var modelContext

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
                DetailStoryButtonView(
                    onRadio: {
                        navigationManager.push(to: .radio(story: viewModel.story))
                    },
                    onClose: {
                        navigationManager.popToRoot()
                    }
                )
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
        .onAppear {
            updateStoryWithRecommendedSong()
            viewModel.setModelContext(modelContext)
        }
        .onDisappear {
            musicRecommendationVM.stopPlayback()
        }
    }
    
    private func updateStoryWithRecommendedSong() {
        if let recommendedTrack = musicRecommendationVM.recommendedTrack,
           viewModel.story.recommendedSongTitle.isEmpty {
            viewModel.story.recommendedSongTitle = recommendedTrack.title
            viewModel.story.recommendedSongAuthor = recommendedTrack.artistName
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

