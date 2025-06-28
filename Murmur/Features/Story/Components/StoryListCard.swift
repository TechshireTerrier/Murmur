//
//  StoryListCard.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import SwiftUI

struct StoryListCard: View {
    let story: Story

    var body: some View {
        VStack {
            // 생성일
            Text(story.createdAt.toFormattedString())
                .font(.PretendardTitle3Bold)
                .foregroundStyle(.text07)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)

            // 사연 내용
            Text(story.content)
                .font(.PretendardBody)
                .foregroundStyle(.text07)
                .lineLimit(3) // 내용을 최대 3줄까지 표시
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)

            // 추천 곡 정보

            HStack {
                Image(systemName: "music.note")
                    .foregroundStyle(.gray500)
                MarqueeText(
                    text: "\(story.recommendedSongAuthor) - \(story.recommendedSongTitle)",
                    font: UIFont(name: "Pretendard-Bold", size: 16)!,
                    color: .text07,
                    leftFade: 16,
                    rightFade: 16,
                    startDelay: 1
                )
//                    Text("\(story.recommendedSongAuthor) -")
//                        .font(.PretendardCallout)
//                        .foregroundStyle(.text07)
//                    Text(story.recommendedSongTitle)
//                        .font(.PretendardCalloutBold)
//                        .foregroundStyle(.text07)
//                        .lineLimit(1)
                Spacer()
            }

            .padding(12)
            .background(Color.gray200)
            .cornerRadius(50)
        }
        .padding()
        .background(Color.gray50)
        .cornerRadius(10)
    }
}

#Preview {
    StoryListCard(story: Story(
        createdAt: Date().addingTimeInterval(-86400 * 1), // 1일 전
        content: "창밖으로 비가 추적추적 내리네요. 이런 날에는 약속도 다 취소하고 집에서 뒹굴거리는 게 최고인 것 같아요. 따뜻한 커피 한 잔 내려서 창가에 앉아 빗소리를 듣고 있으니 마음이 차분해져요. 이 분위기를 더 깊게 만들어 줄 감성적인 연주곡이나 노래가 있다면 알려주세요.",
        recommendedSongAuthor: "Mark Ronson",
        recommendedSongTitle: "Uptown Funk (feat. Bruno Mars)"
    ))
}
