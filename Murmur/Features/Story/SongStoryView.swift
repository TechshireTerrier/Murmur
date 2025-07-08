//
//  SongStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct SongStoryView: View {
    @State private var todayStory: String = "I'd run the risk of losing everything Sell all my things, become nomadic I'd run the risk, and just in case, I might Sell all my things and become the night"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("오늘의 사연")
                    .font(.PretendardTitle1Bold)
                    .accessibilityLabel("오늘의 사연")
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 56)
                
                Button("수정하기") {
                    print("수정하기 버튼 눌림")
                }
                .font(.PretendardBody)
                .foregroundStyle(Color.text04)
                .accessibilityLabel("수정하기")
                .accessibilityAddTraits(.isButton)
            }
            
            Text(todayStory)
                .frame(width: 307)
                .foregroundStyle(Color.gray900)
                .padding(.vertical, 28)
                .frame(width: 361, height: 404, alignment: .top)
                .background(Color.gray50)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .accessibilityLabel("사연 내용")
                .accessibilityAddTraits(.isStaticText)
        }
    }
}

#Preview {
    SongStoryView()
}
