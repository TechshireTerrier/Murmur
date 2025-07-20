//
//  RadioSubtitleView.swift
//  Murmur
//
//  Created by Moo on 7/13/25.
//

import SwiftUI

struct RadioSubtitleView: View {
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.Gray800)
                    .frame(maxWidth: .infinity, minHeight: 80)
                
                Text(subtitle.isEmpty ? "재생을 시작하세요" : subtitle)
                    .font(.PretendardBody)
                    .foregroundColor(subtitle.isEmpty ? .Text04 : .Text01)
                    .multilineTextAlignment(.center)
                    .padding(16)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    ))
                    .id(subtitle)
            }
            .clipped()
            .animation(.easeInOut(duration: 1.2), value: subtitle)
        }
        .padding(20)
        .background(Color.Gray700.opacity(0.3))
        .cornerRadius(16)
    }
}

#Preview("자막 있음") {
    RadioSubtitleView(subtitle: "안녕하세요 Murmur 라디오 시작합니다")
        .preferredColorScheme(.dark)
}

#Preview("자막 없음") {
    RadioSubtitleView(subtitle: "")
        .preferredColorScheme(.dark)
}
