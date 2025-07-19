//
//  StoryMusicView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import SwiftUI
import UIKit

struct StoryMusicView: View {
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    static var widthSize: CGFloat { screenWidth * 0.9 }
    private var generalWidth = SongStoryView.widthSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이 사연의 추천곡")
                .font(.PretendardTitle1Bold)
                .accessibilityLabel("이 사연의 추천곡")
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, 16)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Ladybird")
                        .font(.PretendardTitle2Bold)
                        .foregroundStyle(Color.text07)
                        .accessibilityLabel("노래 제목")
                        .accessibilityAddTraits(.isStaticText)
                    
                    Text("NewDad")
                        .font(.PretendardBody)
                        .foregroundStyle(Color.text07)
                        .accessibilityLabel("노래 가수")
                        .accessibilityAddTraits(.isStaticText)
                }
                .frame(width: StoryMusicView.screenWidth * 0.6, alignment: .leading)
                
                Button {
                    print("재생 버튼 눌림")
                } label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: StoryMusicView.screenWidth * 0.1, height: StoryMusicView.screenWidth * 0.1)
                        .foregroundStyle(Color.text07)
                }
            }
            .padding(24)
            .frame(width: generalWidth)
            .background(Color.gray50)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    StoryMusicView()
}
