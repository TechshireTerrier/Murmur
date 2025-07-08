import SwiftUI

struct WriteView: View {
    @StateObject private var viewModel = WriteViewModel()
    @State private var userInput: String = ""
    @State private var isRecording = false
    @State private var keyboardHeight: CGFloat = 0
    private let placeholder = "오늘 어떤 일이 있었나요?\n하루를 떠올리며 입력해보세요"
    @FocusState private var isTextEditorFocused: Bool

    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea()
                .onTapGesture {
                    isTextEditorFocused = false
                }

            VStack(alignment: .leading, spacing: 24) {
                // 상단 영역
                Button(action: {
                    // 뒤로 가기
                }) {
                    Image("Chevron_Left")
                        .resizable()
                        .frame(width: 17, height: 22)
                        .foregroundColor(Color.text01)
                        .padding(8)
                }

                Text("오늘의 사연을\n신청해보세요")
                    .font(.PretendardTitle1Bold)
                    .foregroundColor(Color.text01)
                    .kerning(0.38)
                    .padding(.top, 24)
                    .padding(.horizontal, 24)

                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.text01)
                        .frame(maxWidth: .infinity, minHeight: 404, maxHeight: 404)

                    TextEditor(text: $userInput)
                        .frame(maxWidth: .infinity, minHeight: 404, maxHeight: 404)
                        .padding(16)
                        .background(Color.clear)
                        .cornerRadius(18)
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
                .padding(.horizontal, 8)

                Spacer() // 상단 고정 목적
            }

            // ✅ 하단 고정 버튼 레이어
            VStack {
                Spacer()

                if isTextEditorFocused {
                    // 키보드 올라온 상태: 작성 완료 버튼 하나만
                    HStack {
                        WriteMurmurButton(
                            title: "작성 완료",
                            font: .PretendardBodySemiBold,
                            backgroundColor: userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.Gray400 : Color.PointMint,
                            foregroundColor: Color.Gray900,
                            cornerRadius: 15
                        ) {
                            if userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                viewModel.showFailAlert = true
                            } else {
                                isTextEditorFocused = false
                                userInput = ""
                            }
                        }
                        .disabled(userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.horizontal, 12)
                    //.padding(.bottom) // ✅ 키보드 위 띄우기
                } else {
                    // 기본 버튼 2개
                    HStack(spacing: 12) {
                        NavigationLink(destination: RecordView(), isActive: $isRecording) {
                            EmptyView()
                        }
                        WriteMurmurButton(
                            title: "음성으로 기록하기",
                            font: .PretendardBodySemiBold,
                            backgroundColor: Color.Gray400,
                            foregroundColor: Color.text07,
                            cornerRadius: 16
                        ) {
                            isRecording = true
                        }
                        WriteMurmurButton(
                            title: "작성 완료",
                            font: .PretendardBodySemiBold,
                            backgroundColor: Color.Gray400,
                            foregroundColor: Color.Gray900,
                            cornerRadius: 15
                        ) {
                            viewModel.showFailAlert = true
                        }
                        .disabled(true)
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 32)
                }
            }
        }
        // ✅ 키보드 높이 감지
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = frame.height
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboardHeight = 0
        }

        // 알림 뷰
        FailAlertView(isPresented: $viewModel.showFailAlert)
    }
}
#Preview {
    WriteView()
        .preferredColorScheme(.dark)
}
