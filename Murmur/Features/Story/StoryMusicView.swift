//
//  StoryMusicView.swift
//  Murmur
//
//  Created by gabi on 6/29/25.
//

import SwiftUI

struct StoryMusicView: View {
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
                .frame(width: 245, alignment: .leading)
                
                Button {
                    print("재생 버튼 눌림")
                } label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color.text07)
                }
            }
            .padding(24)
            .frame(width: 361)
            .background(Color.gray50)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Button {
                print("라디오 듣기 버튼 눌림")
            } label: {
                Text("라디오 듣기")
                    .modifier(LongButtonModifier(buttonColor: Color.keyMint))
            }
            .accessibilityLabel("라디오 듣기")
            .accessibilityAddTraits(.isButton)
            .padding(.top, 40)
            
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
}

#Preview {
    StoryMusicView()
}
