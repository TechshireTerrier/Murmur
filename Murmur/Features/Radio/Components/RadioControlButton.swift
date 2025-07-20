//
//  RadioControlView.swift
//  Murmur
//
//  Created by Moo on 7/13/25.
//

import SwiftUI

struct RadioControlButton: View {
    let isPlaying: Bool
    let didTapPlayButton: () -> Void
    
    var body: some View {
        Button(action: didTapPlayButton) {
            HStack(spacing: 8) {
                Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                    .font(.system(size: 16, weight: .medium))
                
                Text(isPlaying ? "정지" : "재생")
                    .font(.PretendardCalloutBold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(isPlaying ? Color.red : Color.KeyMint)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
    }
}

#Preview("재생 상태") {
    RadioControlButton(isPlaying: false) {
        print("재생 버튼 탭됨")
    }
    .preferredColorScheme(.dark)
}

#Preview("정지 상태") {
    RadioControlButton(isPlaying: true) {
        print("정지 버튼 탭됨")
    }
    .preferredColorScheme(.dark)
}
