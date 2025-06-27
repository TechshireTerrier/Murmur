//
//  WriteView.swift
//  Murmur
//
//  Created by Ethan on 6/27/25.
//

import SwiftUI


struct WriteView: View {
    @State private var userText: String = ""
    @State private var showFailAlert = false //작성완료 상태변수
    
    var body: some View {
        ZStack {
            //Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                HStack {
                    Text("오늘의 사연을\n신청해보세요")
                        .accessibilityLabel("오늘의 사연을 신청해보세요")
                        .foregroundColor(Color.text01)
                        .font(Font.custom("Pretendard", size: 28).weight(.bold))
                        .kerning(0.38)
                    Spacer()
                    
                }
                .padding(.leading, 33.5)
                ZStack(alignment: .topLeading) {
                    if userText.isEmpty {
                        Text("오늘 어떤 일이 있었나요?\n하루를 떠올리며 입력해보세요")
                            .foregroundColor(Color.Gray700)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 27)
                        
                        // Fix 검은색 영역 생기는 문제 의논 필요
                        //                        TextEditor(text: $userText)
                        //                            .foregroundColor(.black)
                        //                            .padding(16)
                        //                            .background(Color.white)
                        //                            .cornerRadius(16)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 404, maxHeight: 404, alignment: .topLeading)
                .background(Color.Gray50)
                .cornerRadius(16)
                .padding(.horizontal, 20)
                
                
                HStack(spacing: 12) {
                    Button(action: {
                        if userText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            showFailAlert = true
                        } else {
                        }
                    }) {
                        Text("작성 완료")
                            .font(Font.custom("Pretendard", size: 17))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.PointMint)
                            .foregroundColor(Color.Gray900)
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                    }) {
                        Text("음성으로 기록하기")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.Gray400)
                            .foregroundColor(Color.text07)
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.top, 60)
            FailAlertView(isPresented: $showFailAlert)
        }
    }
}
#Preview {
    WriteView()
        .preferredColorScheme(.dark)
}
