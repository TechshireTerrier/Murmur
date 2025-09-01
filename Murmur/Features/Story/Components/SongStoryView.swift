//
//  SongStoryView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct SongStoryView: View {
    let story: Story
    let isModify: Bool
    @Binding var newContent: String

    init(story: Story, isModify: Bool = false, newContent: Binding<String> = .constant("")) {
        self.story = story
        self.isModify = isModify
        _newContent = newContent
    }

    var screenWidth: CGFloat { UIScreen.main.bounds.width }
    var screenHeight: CGFloat { UIScreen.main.bounds.height }

    private let placeholder1 = "오늘 어떤 일이 있었나요?"
    private let placeholder2 = "하루를 떠올리며 입력해보세요"
    @FocusState private var isTextEditorFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            if !isModify {
                StoryContentTopView(story: story, isModify: isModify)
                    .frame(width: screenWidth * 0.9)
                    .padding(.top, screenWidth * 0.1)
            } else {
                StoryContentTopView(story: story, isModify: isModify)
                    .frame(width: screenWidth * 0.9)
                    .padding(.top, screenWidth * 0.1)
                    .padding(.horizontal, 16)
            }

            if !isModify {
                ScrollView(.vertical) {
                    Text(story.content)
                        .foregroundStyle(Color.gray900)
                        .padding(screenWidth * 0.07)
                        .accessibilityLabel("사연 내용")
                        .accessibilityAddTraits(.isStaticText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .scrollIndicators(.hidden)
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.5, alignment: .top)
                .background(Color.gray50)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.text01)
                    TextEditor(text: $newContent)
                        .font(.PretendardBody)
                        .padding(16)
                        .background(Color.clear)
                        .cornerRadius(15)
                        .foregroundStyle(Color.text07)
                        .scrollContentBackground(.hidden)
                        .focused($isTextEditorFocused)
                    if newContent.isEmpty {
                        VStack {
                            Text(placeholder1) + Text("\n") + Text(placeholder2)
                        }
                        .foregroundColor(Color.Gray700)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 22)
                        .font(.PretendardBody)
                    }
                }
                .accessibilityLabel(isTextEditorFocused ? "사연 입력중" : "사연 입력란")
                .accessibilityHint(
                    isTextEditorFocused
                        ? "300자까지 작성할 수 있어요."
                        : "오늘 어떤 일이 있었나요? 하루를 떠올리며 입력해보세요."
                )
                .accessibilityAddTraits(.allowsDirectInteraction)
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.5, alignment: .top)
                .padding(.horizontal, 16)
            }
        }
    }
}

struct StoryContentTopView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let story: Story
    let isModify: Bool

    var titleText: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(story.createdAt) {
            return "오늘의 사연"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "M월 d일의 사연"
            return formatter.string(from: story.createdAt)
        }
    }

    var body: some View {
        HStack {
            if !isModify {
                Text(titleText)
                    .font(.PretendardTitle1Bold)
                    .accessibilityLabel(titleText)
                    .accessibilityAddTraits(.isHeader)
            } else {
                Text("\(titleText) 수정하기")
                    .font(.PretendardTitle1Bold)
                    .accessibilityLabel("\(titleText) 수정하기")
                    .accessibilityAddTraits(.isHeader)
            }

            Spacer()

            if !isModify {
                Button("수정하기") {
                    navigationManager.push(to: .modifyStory(story: story))
                }
                .font(.PretendardBody)
                .foregroundStyle(Color.text04)
                .accessibilityLabel("수정하기")
                .accessibilityAddTraits(.isButton)
            }
        }
    }
}

#Preview {
    SongStoryView(story: MockData.sampleStory)
}
