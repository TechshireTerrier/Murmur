//
//  DailyEmotionView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import SwiftUI

struct DailyEmotionView: View {
    let emotions: [String]
//    let isLoading: Bool

    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var widthSize: CGFloat { screenWidth * 0.9 }

    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 감정")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("오늘의 감정")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, DailyEmotionView.screenWidth * 0.04)

//            if isLoading {
//                // 로딩 상태
//                HStack {
//                    ProgressView()
//                        .scaleEffect(0.8)
//                    Text("감정을 분석하고 있어요...")
//                        .font(.PretendardBody)
//                        .foregroundColor(.Text04)
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//            } else if emotions.isEmpty {
//                // 감정이 없을 때
//                Text("감정을 분석할 수 없어요")
//                    .font(.PretendardBody)
//                    .foregroundColor(.Text04)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//            } else {
            // 감정 라벨들 (원래 디자인)
            HStack {
                ForEach(0 ..< emotions.count, id: \.self) { index in
                    Text("\(emotions[index])")
                        .modifier(EmotionLabelModifier())
                        .accessibilityLabel("추출된 감정: \(emotions[index])")
                        .accessibilityAddTraits(.isStaticText)
                }
            }
            .frame(width: DailyEmotionView.screenWidth * 0.9)
//            }
        }
    }
}

struct EmotionCard: View {
    let emotion: EmotionResult

    var body: some View {
        VStack(spacing: 8) {
            Text(emotion.label)
                .font(.PretendardBodyBold)
                .foregroundColor(.Text01)
                .multilineTextAlignment(.center)

//            Text("\(Int(emotion.confidence * 100))%")
//                .font(.PretendardSubheadline)
//                .foregroundColor(.Text04)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.Gray100)
        .cornerRadius(12)
    }
}

#Preview("감정 있음") {
    DailyEmotionView(
        emotions: [
            "기쁨",
            "감동",
            "뿌듯함",
            "설렘",
        ],
//        isLoading: false
    )
    .padding()
}

#Preview("로딩 중") {
    DailyEmotionView(
        emotions: [],
//        isLoading: true
    )
    .padding()
}

#Preview("감정 없음") {
    DailyEmotionView(
        emotions: [],
//        isLoading: false
    )
    .padding()
}
