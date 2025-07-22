//
//  DailyEmotionView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import SwiftUI

struct DailyEmotionView: View {
    @State private var emotions = [
        "기쁨", "벅차오름", "감동적", "뿌듯함"
    ]
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var widthSize: CGFloat { screenWidth * 0.9 }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 감정")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("오늘의 감정")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, DailyEmotionView.screenWidth * 0.04)
            
            HStack {
                ForEach(0..<emotions.count, id: \.self) { index in
                    Text("\(emotions[index])")
                        .modifier(EmotionLabelModifier())
                        .accessibilityLabel("추출된 감정")
                        .accessibilityAddTraits(.isStaticText)
                }
            }
            .frame(width: DailyEmotionView.screenWidth * 0.9)
        }
    }
}

#Preview {
    DailyEmotionView()
}
