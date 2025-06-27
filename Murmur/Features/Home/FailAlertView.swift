//
//  FailAlertView.swift
//  Murmur
//
//  Created by Ethan on 6/28/25.
//

import SwiftUI

struct FailAlertView: View {
    @Binding var isPresented: Bool

    var body: some View {
        if isPresented {
            ZStack {
                // 어두운 배경
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    //Spacer().frame(height: 4)
                    // 알림 아이콘
                    Image("Warning")
                        .resizable()
                        .frame(width: 60, height: 60,alignment: .top)
                        .foregroundColor(Color.PointMint)

                    // 메시지
                    Text("아직 사연이\n작성되지 않았어요")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.text06)
                        .font(.custom("Pretendard", size: 20).weight(.semibold))
                        .frame(width: 168, height: 56, alignment: .top)
                    

                    // 확인 버튼
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("확인")
                            .font(
                                Font.custom("Pretendard", size: 17)
                                    .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.text07)
                            .frame(width: 67, height: 22, alignment: .top)
                        // 위에가 확인 텍스트 영역
                        // 아래가 확인 버튼 영역
                            .padding(.vertical, 9)
                            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .center)
                            //.border(Color.red, width: 1)
                            .background(Color.Gray300)
                            .foregroundColor(Color.text07)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 12)
                .frame(width: 275, alignment: .top)
                .background(Color.gray50)
                .cornerRadius(10)
                //.shadow(radius: 10)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("아직 사연이 작성되지 않았어요")
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
    
}

