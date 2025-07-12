import SwiftUI

struct WriteView: View {
    // MARK: - UI 상수 정의
    private enum Layout {
        static let horizontalPadding: CGFloat = 8
        static let buttonVerticalSpacing: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 15
        static let buttonHeight: CGFloat = 52
        static let textEditorBottomSpacing: CGFloat = 8
    }

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
                    userInput = ""
                }

            VStack(alignment: .leading, spacing: 24) {
                // 상단 타이틀 및 뒤로가기
                Button(action: {
                    // 뒤로 가기 동작 처리
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

                // 텍스트 입력 영역
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.text01)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    TextEditor(text: $userInput)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                .padding(.horizontal, Layout.horizontalPadding)

                // 버튼 2개를 세로로 배치
                VStack(spacing: Layout.buttonVerticalSpacing) {
                    // 작성 완료 버튼: 항상 키컬러, 입력이 비어있을 때도 활성화
                    WriteMurmurButton(
                        title: "작성 완료",
                        font: .PretendardBodySemiBold,
                        backgroundColor: Color.PointMint, // 항상 키컬러
                        foregroundColor: Color.Gray900,
                        cornerRadius: Layout.buttonCornerRadius
                    ) {
                        // 텍스트 필드가 비어있으면 실패 알림, 아니면 정상 처리
                        if userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            viewModel.showFailAlert = true
                        } else {
                            // 사연 작성 완료 처리
                            isTextEditorFocused = false
                            userInput = ""
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: Layout.buttonHeight)

                    WriteMurmurButton(
                        title: "음성으로 기록하기",
                        font: .PretendardBodySemiBold,
                        backgroundColor: Color.Gray400,
                        foregroundColor: Color.text07,
                        cornerRadius: Layout.buttonCornerRadius
                    ) {
                        isRecording = true
                        // 음성 기록 액션
                    }
                    .frame(maxWidth: .infinity, minHeight: Layout.buttonHeight)
                }
                .padding(.horizontal, Layout.horizontalPadding)
                .padding(.top, Layout.textEditorBottomSpacing)

                Spacer()
            }
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
    WriteView()
        .preferredColorScheme(.dark)
}
