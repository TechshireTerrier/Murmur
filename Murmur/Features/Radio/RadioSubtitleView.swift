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
        Rectangle()
            .fill(Color.Gray50)
            .frame(width: 300, height: 60)
            .overlay(
                Text(subtitle)
                    .font(.DXYeonghwaJamak2ExtraBold)
                    .foregroundColor(.Text07)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    ))
                    .id(subtitle)
            )
            .clipped()
            .animation(.easeInOut(duration: 1.2), value: subtitle)
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
