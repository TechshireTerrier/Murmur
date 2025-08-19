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
    
    init(
        story: Story,
        sessionManager: RadioSessionManager = RadioSessionManager(),
        musicRecommendationViewModel: MusicRecommendationViewModel
    ) {
        self.currentStory = story
        self.sessionManager = sessionManager
        self.musicRecommendationViewModel = musicRecommendationViewModel
        // loadInitialData()는 제거 (onAppear에서 호출)
    }
    
    func reloadScriptAndSubtitles() {
        generatedScript = sessionManager.generateScript(from: currentStory)
        if let script = generatedScript {
            subtitleSegments = sessionManager.generateSubtitleSegments(from: script)
        }
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
                    self?.currentSubtitle = ""
                }
            },
            onMusicPlay: { [weak self] in
                DispatchQueue.main.async {
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
    
    private func playRecommendedMusic() {
        print("🔍 playRecommendedMusic 호출됨")
        print("🔍 recommendedTrack: \(String(describing: musicRecommendationViewModel.recommendedTrack))")
        if let track = musicRecommendationViewModel.recommendedTrack {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let musicInfo = "\(track.title) - \(track.artistName)"
                self.currentSubtitle = musicInfo
                self.isMusicPlaying = true
                print("📝 자막에 표시: \(musicInfo)")
                print(" currentSubtitle 상태: \(self.currentSubtitle)")
                self.objectWillChange.send()
            }
            musicRecommendationViewModel.playPreview()
            scheduleMusicCompletion()
        } else {
            // 🆕 최소 변경: Story 정보로 곡 검색 후 재생
            print("⚠️ 추천된 음악이 없습니다. Story 정보로 검색합니다.")
            
            // Story에 곡 정보가 있으면 검색해서 재생
            if !currentStory.recommendedSongTitle.isEmpty && !currentStory.recommendedSongAuthor.isEmpty {
                // 일단 Story 정보를 자막에 표시
                let musicInfo = "\(currentStory.recommendedSongTitle) - \(currentStory.recommendedSongAuthor)"
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.currentSubtitle = musicInfo
                    self.isMusicPlaying = true
                    print("📝 Story 정보로 자막 표시: \(musicInfo)")
                    self.objectWillChange.send()
                }
                
                // 백그라운드에서 실제 곡 검색 후 재생
                Task {
                    await musicRecommendationViewModel.searchSongByTitleAndArtist(currentStory)
                    await MainActor.run {
                        if musicRecommendationViewModel.recommendedTrack != nil {
                            musicRecommendationViewModel.playPreview()
                        }
                    }
                }
                scheduleMusicCompletion()
            } else {
                print("⚠️ Story에도 곡 정보가 없습니다")
                scheduleMusicCompletion()
            }
        }
    }
    
    private func scheduleMusicCompletion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 31.0) { [weak self] in
            DispatchQueue.main.async {
                self?.finishMusicAndSendHomeSignal()
            }
        }
    }
    
    private func finishMusicAndSendHomeSignal() {
        print(" 음악 재생 완료! ON AIR 끄고 홈 이동 신호 전송")
        isPlaying = false
        isMusicPlaying = false
        currentSubtitle = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            DispatchQueue.main.async {
                self?.shouldNavigateToHome = true
            }
        }
    }
}
