import AVFoundation
import Foundation
import Speech
import SwiftData  // 1. SwiftData 임포트
import SwiftUI

@MainActor
class WriteViewModel: ObservableObject {
    @Published var showFailAlert = false

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    func saveStory(content: String, navigationManager: NavigationManager) {
        print("saveStory called with content: '\(content)'")

        if content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print("Content is empty, showing fail alert")
            showFailAlert = true
        } else {
            let story = Story(
                content: content,
                emotions: [],
                recommendedSongAuthor: "",
                recommendedSongTitle: ""
            )
            print("Created Story object with ID: \(story.id)")
            print("Story created at: \(story.createdAt)")

            modelContext.insert(story)
            print("Story inserted into modelContext")

            do {
                try modelContext.save()
                print("Story saved successfully!")
                print("Story ID: \(story.id)")
                print("Story content: \(story.content)")
                print("Story created at: \(story.createdAt)")

                // 저장 후 LoadingView로 이동
                navigationManager.push(to: .loading(story: story))
            } catch {
                print("Failed to save story: \(error)")
                showFailAlert = true
            }
        }
    }
}
class AudioRecorder: NSObject, ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var speechRecognizer = SFSpeechRecognizer(
        locale: Locale(identifier: "ko-KR")
    )
    private var request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?

    @Published var isRecording = false
    var userInputBinding: Binding<String>?

    func startRecording() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.recordAndRecognizeSpeech()
                    self.isRecording = true
                } else {
                    print("음성 인식 권한이 없습니다.")
                }
            }
        }
    }

    func stopRecording() {
        audioEngine.stop()
        request.endAudio()
        isRecording = false
    }

    private func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)

        request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true

        node.removeTap(onBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer, _) in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        try? audioEngine.start()

        recognitionTask = speechRecognizer?.recognitionTask(with: request) {
            result,
            error in
            if let result = result {
                DispatchQueue.main.async {
                    self.userInputBinding?.wrappedValue =
                        result.bestTranscription.formattedString
                }
            } else if let error = error {
                print("음성 인식 오류: \(error.localizedDescription)")
            }
        }
    }
}
