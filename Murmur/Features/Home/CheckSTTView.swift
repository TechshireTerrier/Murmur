//
//  CheckSTTView.swift
//  Murmur
//
//  Created by Ethan on 7/14/25.
//
import SwiftUI


struct CheckSTTView: View {

    @StateObject private var viewModel = WriteViewModel()
    @State private var userInput: String = ""
    @State private var keyboardHeight: CGFloat = 0
    private let placeholder = "녹음 내용 올라와야됨"
    @FocusState private var isTextEditorFocused: Bool

    var body: some View {
        ZStack {
            // 배경색 및 전체 터치 시 포커스 해제
            Color.gray900
                .ignoresSafeArea()
                .onTapGesture {
                    isTextEditorFocused = false
                }

            VStack(alignment: .leading) {

                HStack(alignment: .top) {
                    Text("신청한 사연이 올바른지\n확인해주세요")
                        .font(.PretendardTitle1Bold)
                        .foregroundColor(Color.text01)
                        .kerning(0.38)

                }
                .padding(.top, 24)
                .padding(.horizontal, 24)

                // 텍스트 입력 영역
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius:15)
                        .fill(Color.text01)
                    TextEditor(text: $userInput)
                        .padding(16)
                        .background(Color.clear)
                        .cornerRadius(15)
                        .foregroundStyle(Color.text07)
                        .scrollContentBackground(.hidden)
                        .focused($isTextEditorFocused)
                    if userInput.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color.Gray700)
                            .padding(20)
                            .font(.PretendardBody)
                    }
                }
                .frame(minHeight: 140, maxHeight: 404) // 텍스트 입력 영역 높이 고정
                .padding(.horizontal, 16)
                .padding(.vertical, 20)

                // 작성 완료 버튼 (텍스트 입력 영역 바로 아래)
                WriteMurmurButton(
                    title: "추천곡 듣기",
                    font: .PretendardBodySemiBold,
                    backgroundColor: Color.PointMint,
                    foregroundColor: Color.Gray900,
                    cornerRadius: 15
                ) {
                    if userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        viewModel.showFailAlert = true
                    } else {
                        // 사연 작성 완료 처리
                        isTextEditorFocused = false
                        userInput = ""
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                WriteMurmurButton(
                    title: "다시 말하기",
                    font: .PretendardBodySemiBold,
                    backgroundColor: Color.Gray400,
                    foregroundColor: Color.Gray900,
                    cornerRadius: 15
                ){
                    if userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        viewModel.showFailAlert = true
                    } else {
                        // 사연 작성 완료 처리
                        isTextEditorFocused = false
                        userInput = ""
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 52)
                .padding(.horizontal, 16)
                Spacer()
            }
            .padding(.top, 24) // 전체 VStack 상단 여백

            // 실패 알림 뷰
            FailAlertView(isPresented: $viewModel.showFailAlert)
        }
        // 키보드 높이 감지 및 동적 반영
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = keyboardFrame.height
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboardHeight = 0
        }
    }
}
#Preview {
    CheckSTTView()
        .preferredColorScheme(.dark)
}
