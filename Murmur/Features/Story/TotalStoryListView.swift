//
//  TotalStoryListView.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import SwiftUI

struct TotalStoryListView: View {
    @StateObject private var viewModel = TotalStoryListViewModel()

    var body: some View {
        ZStack {
            Color.gray900.ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()

                    Button(action: {}) {
                        Text("랜덤 사연 읽기")
                            .font(.PretendardBodyBold)
                            .foregroundStyle(.text07)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                    }
                    .background(Color.PointMint)
                    .cornerRadius(50)
                }
                .padding(.bottom, 24)

                // 사연 목록 데이터 유무에 따라 분기 처리
                if viewModel.stories.isEmpty {
                    Spacer()
                    Text("아직 등록된 사연이 없어요.")
                        .foregroundStyle(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.stories) { story in
                                StoryListCard(story: story)
                                    .padding(.bottom, 12)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    TotalStoryListView()
}
