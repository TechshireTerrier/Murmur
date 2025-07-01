//
//  DailyEmotionView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import SwiftUI

struct DailyEmotionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 감정")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("오늘의 감정")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading) {
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
                
                HStack {
                    Text("감동적")
                        .modifier(EmotionLabelModifier())
                        .accessibilityLabel("추출된 감정")
                        .accessibilityAddTraits(.isStaticText)
                    Text("기쁨")
                        .modifier(EmotionLabelModifier())
                        .accessibilityLabel("추출된 감정")
                        .accessibilityAddTraits(.isStaticText)
                    Text("벅차오름")
                        .modifier(EmotionLabelModifier())
                        .accessibilityLabel("추출된 감정")
                        .accessibilityAddTraits(.isStaticText)
                    Text("기쁨")
                        .modifier(EmotionLabelModifier())
                        .accessibilityLabel("추출된 감정")
                        .accessibilityAddTraits(.isStaticText)
                }
            }
            .frame(width: 361)
        }
    }
}

#Preview {
    DailyEmotionView()
}
