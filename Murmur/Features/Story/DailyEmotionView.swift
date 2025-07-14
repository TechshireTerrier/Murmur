//
//  DailyEmotionView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import SwiftUI
import UIKit

struct DailyEmotionView: View {
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var widthSize: CGFloat { screenWidth * 0.9 }
    private var generalWidth = SongStoryView.widthSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 감정")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("오늘의 감정")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, DailyEmotionView.screenWidth * 0.04)
            
            HStack {
                Text("기쁨")
                    .modifier(EmotionLabelModifier())
                    .accessibilityLabel("추출된 감정")
                    .accessibilityAddTraits(.isStaticText)
                Text("벅차오름")
                    .modifier(EmotionLabelModifier())
                    .accessibilityLabel("추출된 감정")
                    .accessibilityAddTraits(.isStaticText)
                Text("감동적")
                    .modifier(EmotionLabelModifier())
                    .accessibilityLabel("추출된 감정")
                    .accessibilityAddTraits(.isStaticText)
                Text("뿌듯함")
                    .modifier(EmotionLabelModifier())
                    .accessibilityLabel("추출된 감정")
                    .accessibilityAddTraits(.isStaticText)
            }
            .frame(width: generalWidth)
        }
    }
}

#Preview {
    DailyEmotionView()
}
