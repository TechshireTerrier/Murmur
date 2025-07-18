import SwiftUI
import AVFoundation
import Speech

class WriteViewModel: ObservableObject {
    @Published var userText: String = ""
    @Published var showFailAlert: Bool = false
}



class AudioRecorder: NSObject, ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
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
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()

        recognitionTask = speechRecognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.userInputBinding?.wrappedValue = result.bestTranscription.formattedString
                }
            } else if let error = error {
                print("음성 인식 오류: \(error.localizedDescription)")
            }
        }
    }
}
