import SwiftUI
import AVFoundation
import Speech

struct WriteView: View {

    @StateObject private var viewModel = WriteViewModel()
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var userInput: String = ""
    @State private var keyboardHeight: CGFloat = 0
    private let placeholder = "오늘 어떤 일이 있었나요?\n하루를 떠올리며 입력해보세요"
    @FocusState private var isTextEditorFocused: Bool
    @EnvironmentObject private var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            // 배경색 및 전체 터치 시 포커스 해제
            Color.gray900
                .ignoresSafeArea()
                .onTapGesture {
                    isTextEditorFocused = false
                }

            VStack(alignment: .leading, spacing: 24) {
                // 상단 뒤로가기 버튼
                Button(action: {
                    // 뒤로 가기 동작 처리
                }) {
                    Image("Chevron_Left")
                        .resizable()
                        .frame(width: 17,height: 22)
                        .foregroundColor(Color.text01)
                        .padding(8)
                }

                HStack(alignment: .top) {
                    Text("오늘의 사연을\n신청해보세요")
                        .font(.PretendardTitle1Bold)
                        .foregroundColor(Color.text01)
                        .kerning(0.38)

                    Spacer()

                    Button(action: {
                        if audioRecorder.isRecording {
                            audioRecorder.stopRecording()
                        } else {
                            audioRecorder.startRecording()
                        }
                    }) {
                        Image(systemName: "microphone.fill")
                            .resizable()
                            .frame(width: 20, height: 30)
                            .foregroundColor(Color.text01)
                    }
                    .padding(.top, 28) // 텍스트 첫줄 높이에 맞춰 약간 내려줌
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

                // 작성 완료 버튼 (텍스트 입력 영역 바로 아래)
                WriteMurmurButton(
                    title: "작성 완료",
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
                .frame(maxWidth: .infinity, minHeight: 52)
                .padding(.horizontal, 16)
                Spacer()
            }
            .padding(.top, 24) // 전체 VStack 상단 여백

            // 실패 알림 뷰
            FailAlertView(isPresented: $viewModel.showFailAlert)
        }
        .onAppear {
            audioRecorder.userInputBinding = $userInput
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
