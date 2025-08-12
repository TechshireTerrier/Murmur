import AVFoundation
import Speech
import SwiftData
import SwiftUI

struct WriteView: View {
    let modelContext: ModelContext
    @StateObject private var viewModel: WriteViewModel
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var userInput: String = ""
    @State private var keyboardHeight: CGFloat = 0
    private let placeholder = "오늘 어떤 일이 있었나요?\n하루를 떠올리며 입력해보세요"
    @FocusState private var isTextEditorFocused: Bool
    @EnvironmentObject private var navigationManager: NavigationManager

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: WriteViewModel(modelContext: modelContext))
    }

    var body: some View {
        ZStack {
            // 배경색 및 전체 터치 시 포커스 해제
            Color.gray900
                .ignoresSafeArea()
                .onTapGesture {
                    isTextEditorFocused = false
                }

            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top) {
                    Text("오늘의 사연을\n신청해보세요")
                        .accessibilityLabel("오늘의 사연을 신청해보세요")
                        .accessibilityAddTraits(.isHeader)
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
                    .accessibilityLabel("음성으로 기록하기")
                    .accessibilityAddTraits(.isButton)
                    .padding(.top, 28) // 텍스트 첫줄 높이에 맞춰 약간 내려줌
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)

                // 텍스트 입력 영역
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 15)
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
                .accessibilityLabel(isTextEditorFocused ? "사연 입력중" : "사연 입력란")
                .accessibilityHint(isTextEditorFocused ? "300자까지 작성할 수 있어요." : "오늘 어떤 일이 있었나요? 하루를 떠올리며 입력해보세요.")
                .accessibilityAddTraits(.allowsDirectInteraction)
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

                        // Story 생성 시 modelContext 사용
                        let userStory = Story(
                            content: userInput,
                            emotions: [], // 빈 배열로 시작
                            recommendedSongAuthor: "",
                            recommendedSongTitle: ""
                        )

                        // LoadingView로 이동하면서 story 전달
                        navigationManager.push(to: .loading(story: userStory))

                        userInput = ""
                    }
                }
                .accessibilityLabel("작성 완료")
                .accessibilityAddTraits(.isButton)
                .frame(maxWidth: .infinity, minHeight: 52)
                .padding(.horizontal, 16)
                Spacer()
            }
            .padding(.top, 24) // 전체 VStack 상단 여백

            // 실패 알림 뷰
            FailAlertView(isPresented: $viewModel.showFailAlert)
        }
        .navigationBarBackButtonHidden()
        .enableSwipeBack()
        .toolbar {
            CustomBackButton {
                navigationManager.pop()
            }
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Story.self, configurations: config)

    return WriteView(modelContext: container.mainContext)
        .preferredColorScheme(.dark)
}
