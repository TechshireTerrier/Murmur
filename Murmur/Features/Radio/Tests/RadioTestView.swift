//
//  RadioTestView.swift
//  Murmur
//
//  Edited by Moo on 7/13/25.
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
                        
                        UserStorySection(story: viewModel.currentStory)
                        
                        RadioSubtitleView(subtitle: viewModel.currentSubtitle)
                        
                        RadioControlButton(
                            isPlaying: viewModel.isPlaying,
                            didTapPlayButton: {
                                viewModel.playButtonTapped()
                            }
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("라디오 테스트")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
    }
}

struct UserStorySection: View {
    let story: UserStory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("사용자 스토리")
                .font(.PretendardTitle3Bold)
                .foregroundColor(.KeyMint)
            
            VStack(alignment: .leading, spacing: 12) {
                PropertyRow(title: "생성일", value: story.createdAt.toFormattedString())
                PropertyRow(title: "감정 키워드", value: story.emotionKeywords.joined(separator: ", "))
                PropertyRow(title: "추천곡", value: "\(story.recommendedSongAuthor) - \(story.recommendedSongTitle)")
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("내용")
                    .font(.PretendardCalloutBold)
                    .foregroundColor(.Text03)
                
                Text(story.content)
                    .font(.PretendardBody)
                    .foregroundColor(.Text02)
                    .lineSpacing(4)
                    .padding(16)
                    .background(Color.Gray800)
                    .cornerRadius(12)
            }
        }
        .padding(20)
        .background(Color.Gray800.opacity(0.5))
        .cornerRadius(16)
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
