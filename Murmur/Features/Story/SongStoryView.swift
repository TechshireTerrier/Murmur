//
//  SongStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI
import UIKit

struct SongStoryView: View {
    @State private var todayStory: String = "I'd run the risk of losing everything Sell all my things, become nomadic I'd run the risk, and just in case, I might Sell all my things and become the night."
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { UIScreen.main.bounds.height }
    static var widthSize: CGFloat { screenWidth * 0.9 }
    private var generalWidth = SongStoryView.widthSize
    
    var body: some View {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("오늘의 사연")
                        .font(.PretendardTitle1Bold)
                        .accessibilityLabel("오늘의 사연")
                        .accessibilityAddTraits(.isHeader)
                    
                    Spacer()
                    
                    Button("수정하기") {
                        print("수정하기 버튼 눌림")
                    }
                    .font(.PretendardBody)
                    .foregroundStyle(Color.text04)
                    .accessibilityLabel("수정하기")
                    .accessibilityAddTraits(.isButton)
                }
                .frame(width: generalWidth)
                .padding(.top, SongStoryView.screenWidth * 0.1)

                
                    ScrollView {
                        Text(todayStory)
                            .foregroundStyle(Color.gray900)
                            .padding(SongStoryView.screenWidth * 0.07)
                            .accessibilityLabel("사연 내용")
                            .accessibilityAddTraits(.isStaticText)
                    }
                    .frame(width: generalWidth, height: SongStoryView.screenHeight * 0.5, alignment: .top)
                    .background(Color.gray50)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
    }
}

#Preview {
    SongStoryView()
}
