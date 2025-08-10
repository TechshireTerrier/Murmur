//
//  SongView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct DetailStoryView: View {
    @EnvironmentObject private var musicRecommendationVM: MusicRecommendationViewModel
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    SongStoryView()
                    DailyEmotionView()
                    StoryMusicView(musicRecommendationVM: musicRecommendationVM)
                }
                DetailStoryButtonView()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarBackButtonHidden()
        .onDisappear {
            musicRecommendationVM.stopPlayback()
        }
    }
}

#Preview {
    DetailStoryView()
}
