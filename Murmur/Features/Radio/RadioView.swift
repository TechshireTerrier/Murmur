//
//  RadioView.swift
//  Murmur
//
//  Created by Muchan Kim on 8/10/25.
//

import SwiftUI

struct RadioView: View {
    @StateObject private var viewModel: RadioViewModel
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel

    let story: Story

    init(story: Story) {
        self.story = story
        _viewModel = StateObject(wrappedValue: RadioViewModel(
            story: story,
            musicRecommendationViewModel: MusicRecommendationViewModel()
        ))
    }

    var body: some View {
        ZStack {
            Color.Gray900
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(height: 244)

                OnAirSignView(isOn: viewModel.isPlaying)
                    .padding(.bottom, 54)

                RadioSubtitleView(subtitle: viewModel.currentSubtitle)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .enableSwipeBack()
        .toolbar {
            CustomBackButton {
                navigationManager.pop()
            }
        }
        .onAppear {
            print(" RadioView onAppear")
            print("🔍 musicRecommendationVM.recommendedTrack: \(String(describing: musicRecommendationVM.recommendedTrack))")
            viewModel.reloadScriptAndSubtitles()
            viewModel.setMusicViewModel(musicRecommendationVM)
            viewModel.startPlaying()
        }
        .onDisappear {
            viewModel.stopPlaying()
        }
        .onChange(of: viewModel.shouldNavigateToHome) { shouldNavigate in
            if shouldNavigate {
                print(" View에서 홈 이동 신호 감지! 홈으로 이동")
                navigationManager.popToRoot()
            }
        }
    }
}

#Preview {
    NavigationView {
        RadioView(story: MockData.sampleStory)
            .environmentObject(NavigationManager())
            .environmentObject(MusicRecommendationViewModel())
    }
}
