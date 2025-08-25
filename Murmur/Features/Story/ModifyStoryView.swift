//
//  ModifyStoryView.swift
//  Murmur
//
//  Created by 김현기 on 8/18/25.
//

import SwiftUI

struct ModifyStoryView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @Environment(\.modelContext) private var modelContext

    @State private var newContent: String
    var story: Story

    init(story: Story) {
        self.story = story
        _newContent = State(initialValue: story.content)
    }

    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    SongStoryView(story: story, isModify: true, newContent: $newContent)
                }

                Button {
                    story.content = newContent
                    do {
                        try modelContext.save()
                        print("Story modified successfully")
                    } catch {
                        print("Failed to modify story: \(error)")
                    }
                    navigationManager.pop()
                } label: {
                    Text("수정 완료")
                        .modifier(LongButtonModifier(buttonColor: Color.keyMint))
                }
                .accessibilityLabel("수정 완료")
                .accessibilityAddTraits(.isButton)
                .padding(.top, 20)

                Button {
                    navigationManager.pop()
                } label: {
                    Text("뒤로 가기")
                        .modifier(LongButtonModifier(buttonColor: Color.gray400))
                }
                .accessibilityLabel("뒤로 가기")
                .accessibilityHint("뒤로 가기를 누르면 다시 뒤로 돌아가요")
                .accessibilityAddTraits(.isButton)
            }
            .frame(maxWidth: .infinity)
        }
        .onTapGesture {
                    hideKeyboard()
                }
        .navigationBarBackButtonHidden()
    }
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

#Preview {
    let story = Story(content: "This is a sample story content.")
    ModifyStoryView(story: story)
}
