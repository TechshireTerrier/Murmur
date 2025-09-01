//
//  StoryMusicView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import MusicKit
import SwiftUI

struct StoryMusicView: View {
    @ObservedObject var musicRecommendationVM: MusicRecommendationViewModel
    var screenWidth: CGFloat { UIScreen.main.bounds.width }
    var screenHeight: CGFloat { UIScreen.main.bounds.height }

    var body: some View {
        VStack(alignment: .leading) {
            Text("이 사연의 추천곡")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("이 사연의 추천곡")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, 16)

            HStack {
                if musicRecommendationVM.recommendedTrack != nil {
                    HStack {
                        if let artwork = musicRecommendationVM.recommendedTrack?.artwork {
                            ArtworkImage(artwork, width: 50)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.trailing, 8)
                        }

                        VStack(alignment: .leading) {
                            MarqueeText(
                                text: musicRecommendationVM.recommendedTrack?.title ?? "노래 제목",
                                font: UIFont(name: "Pretendard-Bold", size: 22)!,
                                color: Color.text07,
                                leftFade: 16,
                                rightFade: 16,
                                startDelay: 1
                            )
                            .accessibilityLabel(musicRecommendationVM.recommendedTrack?.title ?? "노래 제목")
                            .accessibilityAddTraits(.isStaticText)

                            MarqueeText(
                                text: musicRecommendationVM.recommendedTrack?.artistName ?? "노래 가수",
                                font: UIFont(name: "Pretendard-Regular", size: 17)!,
                                color: Color.text07,
                                leftFade: 16,
                                rightFade: 16,
                                startDelay: 1
                            )
                            .accessibilityLabel(musicRecommendationVM.recommendedTrack?.artistName ?? "노래 가수")
                            .accessibilityAddTraits(.isStaticText)
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.vertical, 8)

                    Button {
                        if musicRecommendationVM.isMusicPlaying {
                            musicRecommendationVM.stopPlayback()
                        } else {
                            musicRecommendationVM.playPreview()
                        }
                    } label: {
                        if musicRecommendationVM.isMusicPlaying {
                            Image(systemName: "stop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(Color.text07)
                        } else {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(Color.text07)
                        }
                    }
                    .padding(.trailing, 8)
                    
                } else {
                    HStack {
                        Image(systemName: "music.note")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.mint900)
                            .padding(.trailing, 8)
                        Text("추천곡을 불러오는 중입니다...")
                            .font(.PretendardBodySemiBold)
                            .foregroundColor(Color.text07)
                            .accessibilityLabel("추천곡을 불러오는 중입니다")

                        Spacer().frame(width: 16)

                        ProgressView()
                            .tint(.mint900)
                            .frame(height: 50)
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding(12)
            .frame(width: screenWidth * 0.9)
            .background(Color.gray50)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    StoryMusicView(musicRecommendationVM: MusicRecommendationViewModel())
}
