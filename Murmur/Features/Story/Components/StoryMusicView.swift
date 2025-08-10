//
//  StoryMusicView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import MusicKit
import SwiftUI

struct StoryMusicView: View {
    let musicRecommendationVM: MusicRecommendationViewModel

    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var widthSize: CGFloat { screenWidth * 0.9 }

    var body: some View {
        VStack(alignment: .leading) {
            Text("이 사연의 추천곡")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("이 사연의 추천곡")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, 16)

            HStack {
                HStack {
                    if let artwork = musicRecommendationVM.recommendedTrack?.artwork {
                        ArtworkImage(artwork, width: 100)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.trailing, 16)
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
                .frame(width: StoryMusicView.screenWidth * 0.7, alignment: .leading)

                Button {
                    print("재생 버튼 눌림")
                    musicRecommendationVM.playPreview()
                } label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: StoryMusicView.screenWidth * 0.1, height: StoryMusicView.screenWidth * 0.1)
                        .foregroundStyle(Color.text07)
                }
            }
            .padding(12)
            .frame(width: StoryMusicView.screenWidth * 0.9)
            .background(Color.gray50)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    StoryMusicView(musicRecommendationVM: MusicRecommendationViewModel())
}
