//
//  WriteView.swift
//  Murmur
//
//  Created by Ethan on 6/27/25.
//

import SwiftUI

struct WriteView: View {
    @StateObject private var viewModel = WriteViewModel()
    @EnvironmentObject private var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("오늘의 사연을\n신청해보세요")
                        .accessibilityLabel("오늘의 사연을 신청해보세요")
                        .foregroundColor(Color.text01)
                        .font(.PretendardTitle1SemiBold)
                        .kerning(0.38)
                    Spacer()
                }
                .padding(.leading, 33.5)

                ZStack(alignment: .topLeading) {
                    if viewModel.userText.isEmpty {
                        Text("오늘 어떤 일이 있었나요?\n하루를 떠올리며 입력해보세요")
                            .foregroundColor(Color.Gray700)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 27)
                            .accessibilityLabel("오늘 어떤 일이 있었나요?\n하루를 떠올리며 입력해보세요")
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 404, maxHeight: 404, alignment: .topLeading)
                .background(Color.Gray50)
                .cornerRadius(16)
                .padding(.horizontal, 20)

                HStack(spacing: 12) {
                    WriteMurmurButton(
                        title: "작성 완료",
                        font: .PretendardBodySemiBold,
                        backgroundColor: Color.PointMint,
                        foregroundColor: Color.Gray900,
                        cornerRadius: 15
                    ) {
                        if viewModel.userText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            viewModel.showFailAlert = true
                        } else {
                            // 사연 작성 완료 처리
                        }
                    }

                    WriteMurmurButton(
                        title: "음성으로 기록하기",
                        font: .PretendardBodySemiBold,
                        backgroundColor: Color.Gray400,
                        foregroundColor: Color.text07,
                        cornerRadius: 16
                    ) {
                        // 음성 기록 액션
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 60)

            FailAlertView(isPresented: $viewModel.showFailAlert)
        }
        .navigationBarBackButtonHidden()
        .enableSwipeBack()
        .toolbar {
            CustomBackButton {
                navigationManager.pop()
            }
        }
    }
}

#Preview {
    WriteView()
        .preferredColorScheme(.dark)
}
