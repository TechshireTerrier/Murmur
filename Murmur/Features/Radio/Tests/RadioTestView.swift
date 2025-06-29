//
//  TestView.swift
//  Murmur
//
//  Created by Muchan Kim on 6/29/25.
//

import SwiftUI

struct RadioTestView: View {
    @StateObject private var viewModel = RadioTestViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.Gray900
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // UserStory 프로퍼티 표시
                        VStack(alignment: .leading, spacing: 16) {
                            Text("야생의 데이터")
                                .font(.PretendardTitle3Bold)
                                .foregroundColor(.KeyMint)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                PropertyRow(title: "ID", value: viewModel.currentStory.id.uuidString)
                                PropertyRow(title: "생성일", value: viewModel.currentStory.createdAt.toFormattedString())
                                PropertyRow(title: "감정 키워드", value: viewModel.currentStory.emotionKeywords.joined(separator: ", "))
                                PropertyRow(title: "추천곡 아티스트", value: viewModel.currentStory.recommendedSongAuthor)
                                PropertyRow(title: "추천곡 제목", value: viewModel.currentStory.recommendedSongTitle)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("사연 내용")
                                    .font(.PretendardCalloutBold)
                                    .foregroundColor(.Text03)
                                
                                Text(viewModel.currentStory.content)
                                    .font(.PretendardBody)
                                    .foregroundColor(.Text02)
                                    .padding(16)
                                    .background(Color.Gray800)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(20)
                        .background(Color.Gray800.opacity(0.5))
                        .cornerRadius(16)
                        
                        // 생성된 라디오 스크립트 표시
                        VStack(alignment: .leading, spacing: 16) {
                            Text("생성된 라디오 스크립트")
                                .font(.PretendardTitle3Bold)
                                .foregroundColor(.PointMint)
                            
                            Text(viewModel.generatedScript.fullScript)
                                .font(.PretendardBody)
                                .foregroundColor(.Text02)
                                .lineSpacing(4)
                                .padding(20)
                                .background(Color.Gray800)
                                .cornerRadius(16)
                        }
                        .padding(20)
                        .background(Color.Gray700.opacity(0.3))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("스크립트 확인 용 임시 뷰")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
    }
}

struct PropertyRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.PretendardCalloutBold)
                .foregroundColor(.Text04)
            
            Text(value)
                .font(.PretendardCallout)
                .foregroundColor(.Text02)
                .padding(.leading, 8)
        }
    }
}

#Preview {
    RadioTestView()
}

