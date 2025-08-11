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
                    // TODO: 예시) 검색어를 "Happy"로 지정, 실제로는 원하는 검색어로 변경
                    await musicRecommendationVM.searchAndRecommendSong(searchTerm: "Happy")
                }
            }
            .onChange(of: musicRecommendationVM.recommendedTrack) { newValue in
                if newValue != nil {
                    navigationManager.push(to: .detailStory)
                }
            }
        } else {
            // 권한이 없을 때 보여줄 뷰
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
    LoadingView()
}
