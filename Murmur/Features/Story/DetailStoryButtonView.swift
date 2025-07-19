//
//  DetailStoryButtonView.swift
//  Murmur
//
//  Created by gabi on 7/14/25.
//

import SwiftUI

struct DetailStoryButtonView: View {
    var body: some View {
        Button {
            print("라디오 듣기 버튼 눌림")
        } label: {
            Text("라디오 듣기")
                .modifier(LongButtonModifier(buttonColor: Color.keyMint))
        }
        .accessibilityLabel("라디오 듣기")
        .accessibilityAddTraits(.isButton)
        .padding(.top, 20)
        
        Button {
            print("닫기 버튼 눌림")
        } label: {
            Text("닫기")
                .modifier(LongButtonModifier(buttonColor: Color.gray400))
        }
        .accessibilityLabel("닫기")
        .accessibilityHint("닫기 버튼을 누르면 다시 첫 화면으로 돌아가요")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    DetailStoryButtonView()
}
