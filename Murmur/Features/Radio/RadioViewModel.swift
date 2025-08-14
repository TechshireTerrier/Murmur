//
//  RadioTestViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 8/10/25.
//

import Foundation

@MainActor
final class RadioViewModel: ObservableObject {
    @Published var currentStory: Story
    @Published var generatedScript: RadioScript?
    @Published var isPlaying: Bool = false
    @Published var currentSubtitle: String = ""
    @Published var isMusicPlaying: Bool = false
    @Published var shouldNavigateToHome: Bool = false

    private let sessionManager: RadioSessionManager
    private var musicRecommendationViewModel: MusicRecommendationViewModel
    private var subtitleSegments: [SubtitleSegment] = []
    
    init(sessionManager: RadioSessionManager = RadioSessionManager(),
         musicRecommendationViewModel: MusicRecommendationViewModel) {
        self.sessionManager = sessionManager
        self.musicRecommendationViewModel = musicRecommendationViewModel
        self.currentStory = MockData.sampleStory
        
        loadInitialData()
    }
    
    func setMusicViewModel(_ viewModel: MusicRecommendationViewModel) {
        print("🔧 setMusicViewModel 호출됨")
        print("🔧 전달받은 recommendedTrack: \(String(describing: viewModel.recommendedTrack))")
        
        self.musicRecommendationViewModel = viewModel
        
        print("🔧 설정 완료: \(String(describing: self.musicRecommendationViewModel.recommendedTrack))")
    }
    
    func startPlaying() {
        guard !subtitleSegments.isEmpty else { return }
        
        isPlaying = true
        
        sessionManager.play(
            segments: subtitleSegments,
            onSubtitleChange: { [weak self] subtitle in
                DispatchQueue.main.async {
                    self?.currentSubtitle = subtitle
                }
            },
            complete: { [weak self] in
                DispatchQueue.main.async {
                    // TTS 완료 후에도 isPlaying을 true로 유지
                    self?.currentSubtitle = ""
                }
            },
            onMusicPlay: { [weak self] in
                DispatchQueue.main.async {
                    // TTS 완료 후 추천된 음악 재생
                    self?.playRecommendedMusic()
                }
            }
        )
    }
    
    func stopPlaying() {
        print("🛑 RadioViewModel stopPlaying 호출됨")
        
        sessionManager.stop()
        musicRecommendationViewModel.stopPlayback()
        
        isPlaying = false
        isMusicPlaying = false
        currentSubtitle = ""
        
        print("🛑 모든 재생 상태 정지 완료")
    }
    
    // 추천된 음악 재생 메서드
    private func playRecommendedMusic() {
        print("🔍 playRecommendedMusic 호출됨")
        print("🔍 recommendedTrack: \(String(describing: musicRecommendationViewModel.recommendedTrack))")
        
        // 이미 추천된 음악이 있다면 미리듣기 재생
        if let track = musicRecommendationViewModel.recommendedTrack {
            
            // 음악 정보를 자막에 표시
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let musicInfo = "\(track.title) - \(track.artistName)"
                self.currentSubtitle = musicInfo
                self.isMusicPlaying = true
                
                print("📝 자막에 표시: \(musicInfo)")
                print(" currentSubtitle 상태: \(self.currentSubtitle)")
                
                // UI 강제 업데이트를 위한 추가 설정
                self.objectWillChange.send()
            }
            
            musicRecommendationViewModel.playPreview()
            
            // 음악 재생 완료 후 홈으로 이동 신호 전송
            scheduleMusicCompletion()
        } else {
            print("⚠️ 추천된 음악이 없습니다")
            // 음악이 없어도 홈으로 이동 신호 전송
            scheduleMusicCompletion()
        }
    }
    
    // 음악 완료 후 홈으로 이동 신호 전송
    private func scheduleMusicCompletion() {
        // 30초 미리듣기 + 1초 여유시간 후 완료 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 31.0) { [weak self] in
            DispatchQueue.main.async {
                self?.finishMusicAndSendHomeSignal()
            }
        }
    }
    
    // 음악 완료 처리 및 홈 이동 신호 전송
    private func finishMusicAndSendHomeSignal() {
        print(" 음악 재생 완료! ON AIR 끄고 홈 이동 신호 전송")
        
        // ON AIR 끄기
        isPlaying = false
        isMusicPlaying = false
        currentSubtitle = ""
        
        // 1.0초 후 홈 이동 신호 전송
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            DispatchQueue.main.async {
                self?.shouldNavigateToHome = true
            }
        }
    }
        
    private func loadInitialData() {
        generatedScript = sessionManager.generateScript(from: currentStory)
        
        if let script = generatedScript {
            subtitleSegments = sessionManager.generateSubtitleSegments(from: script)
        }
    }
}