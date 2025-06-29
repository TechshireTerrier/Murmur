
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
                Color.gray900.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 12) {
                    
                    // 알림 아이콘
                    Image("Warning")
                        .resizable()
                        .frame(width: 60, height: 60,alignment: .top)
                        .foregroundColor(Color.PointMint)
                        .accessibilityLabel("경고 사이렌")
                        .padding(.top,12)
                    
                    // 메시지
                    Text("아직 사연이\n작성되지 않았어요")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.text06)
                        .font(.PretendardTitle3SemiBold)
                        .accessibilityLabel("아직 사연이\n작성되지 않았어요")
                    
                    // 확인 버튼
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("확인")
                            .font(.PretendardBodySemiBold
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.text07)
                        // 아래가 확인 버튼 영역
                            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .center)
                            .background(Color.Gray300)
                            .foregroundColor(Color.text07)
                            .cornerRadius(10)
                            .accessibilityLabel("확인")
                            .padding(.vertical, 12)
                    }
                }
                .padding(.horizontal, 11)
                .frame(width: 275, alignment: .top)
                .background(Color.gray50)
                .cornerRadius(10)
              .accessibilityElement(children: .combine)
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
    
}

