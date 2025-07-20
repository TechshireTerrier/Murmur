//
//  LoadingView.swift
//  Murmur
//
//  Created by gabi on 7/7/25.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject private var navigationManager: NavigationManager

    var body: some View {
        VStack {
            Image(systemName: "music.quarternote.3")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(Color.keyMint)
                .accessibilityLabel("음표들")
                .accessibilityAddTraits(.isImage)
                .padding()

            Text("사연에 딱 맞는\n곡을 고르는 중이에요")
                .multilineTextAlignment(.center)
                .font(.PretendardTitle2Bold)
                .accessibilityLabel("사연에 딱 맞는 곡을 고르는 중이에요")
                .accessibilityAddTraits(.isStaticText)
        }
        // TODO: 일단 내부 로직이 없어서 3초 뒤에 넘어가도록 설정해둠. 수정 필요.
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                navigationManager.push(to: .detailStory)
            }
        }
    }
}

#Preview {
    LoadingView()
}
