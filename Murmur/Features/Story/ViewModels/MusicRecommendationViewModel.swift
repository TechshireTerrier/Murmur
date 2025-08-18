//
//  MusicRecommendationViewModel.swift
//  Murmur
//
//  Created by 김현기 on 7/21/25.
//

import AVFoundation
import MusicKit
import SwiftUI

protocol MusicPreviewable {
    var title: String { get }
    var artistName: String { get }
    var previewAssets: [PreviewAsset]? { get }
}

extension Song: MusicPreviewable {}
extension Track: MusicPreviewable {}

class MusicRecommendationViewModel: ObservableObject {
    @Published var isMusicAuthorized: Bool = false
    @Published var foundPlaylist: Playlist?
    @Published var recommendedTrack: MusicPreviewable?
    @Published var playerItem: AVPlayerItem?
    @Published var isMusicPlaying: Bool = false // 음악 재생 상태 추가

    private let player: AVPlayer = .init()
    private var musicCompletionTimer: Timer? // 음악 완료 타이머 추가

    // 1️⃣ MusicKit 권한을 요청하는 비동기 함수
    @MainActor
    func requestMusicAuthorization() async {
        // 1. MusicAuthorization.request()를 호출하여 권한을 요청
        let status = await MusicAuthorization.request()

        // 2. 반환된 상태(status)에 따라 분기 처리
        switch status {
        case .authorized:
            // 3. 권한이 승인되었으면 isMusicAuthorized 상태를 true로 변경
            isMusicAuthorized = true
            print("MusicAuthorization: 승인됨")

        case .denied:
            print("MusicAuthorization: 거부됨")

        // 실제 앱에서는 설정으로 이동하여 권한을 변경하도록 안내하는 UI 필요
        case .restricted:
            print("MusicAuthorization: 제한됨 (예: 자녀 보호 기능)")

        case .notDetermined:
            print("MusicAuthorization: 아직 결정되지 않음")

        @unknown default:
            print("MusicAuthorization: 알 수 없는 새로운 상태")
        }
    }

    func searchSongByTitleAndArtist(title: String, artist: String) async {
        let searchTerm = "\(title) \(artist)"
        do {
            var request = MusicCatalogSearchRequest(term: searchTerm, types: [Song.self])
            request.limit = 1
            let response = try await request.response()

            if let song = response.songs.first {
                await MainActor.run {
                    self.recommendedTrack = song
                }
                print("검색된 곡: \(song.title) by \(song.artistName)")
            } else {
                print("검색 결과에 곡이 없습니다.")
            }
        } catch {
            print("Error performing initial music search: \(error.localizedDescription)")
        }
    }

    // 2️⃣ 검색 및 랜덤 곡 추천 로직을 수행하는 함수
    func searchAndRecommendSong(searchTerm: String) async {
        do {
            // 플레이리스트 검색
            var request = MusicCatalogSearchRequest(term: searchTerm, types: [Playlist.self])
            request.limit = 1
            let response = try await request.response()

            // 검색된 첫 번째 플레이리스트를 가져옴
            guard let foundPlaylist = response.playlists.first else {
                print("검색 결과에 플레이리스트가 없습니다.")
                await searchAndRecommendSong(searchTerm: "명동") // 기본 검색어로 다시 시도
                return
            }

            // UI 업데이트를 위해 메인 스레드에서 상태 변수에 할당
            await MainActor.run {
                self.foundPlaylist = foundPlaylist
            }

            // 트랙 목록을 포함한 상세 플레이리스트 정보를 다시 요청
            let detailedPlaylist = try await foundPlaylist.with(.tracks)

            // 플레이리스트의 트랙 중에서 랜덤으로 하나를 선택
            if let randomTrack = detailedPlaylist.tracks?.randomElement() {
                // UI 업데이트를 위해 메인 스레드에서 상태 변수에 할당
                await MainActor.run {
                    self.recommendedTrack = randomTrack
                }
            }

        } catch {
            print("플레이리스트 검색 또는 곡 가져오기 오류: \(error.localizedDescription)")
        }
    }

    // 3️⃣ 미리듣기 노래를 재생하는 함수
    func playPreview() {
        Task {
            guard let previewAsset = recommendedTrack?.previewAssets?.first,
                  let url = previewAsset.url
            else {
                print("미리듣기를 지원하지 않는 곡이거나 URL이 없습니다.")
                return
            }

            await MainActor.run {
                playerItem = AVPlayerItem(url: url)
                player.replaceCurrentItem(with: playerItem)
                player.play()

                // 음악 재생 상태 시작
                isMusicPlaying = true

                // 음악 완료 타이머 설정 (30초 미리듣기 + 여유시간)
                startMusicCompletionTimer()
            }

            print("\(String(describing: recommendedTrack?.title)) 30초 미리듣기를 재생합니다.")
        }
    }

    // 4️⃣ 플레이어를 정지하는 함수
    func stopPlayback() {
        player.pause()
        player.replaceCurrentItem(with: nil)

        // 음악 재생 상태 정지
        isMusicPlaying = false

        // 타이머 정리
        stopMusicCompletionTimer()

        print("플레이어를 정지했습니다.")
    }

    // 5️⃣ 음악 완료 타이머 시작
    private func startMusicCompletionTimer() {
        // 기존 타이머 정리
        stopMusicCompletionTimer()

        // 30초 미리듣기 + 1초 여유시간 후 완료 처리
        musicCompletionTimer = Timer.scheduledTimer(withTimeInterval: 31.0, repeats: false) { [weak self] _ in
            DispatchQueue.main.async {
                self?.onMusicCompleted()
            }
        }
    }

    // 6️⃣ 음악 완료 타이머 정지
    private func stopMusicCompletionTimer() {
        musicCompletionTimer?.invalidate()
        musicCompletionTimer = nil
    }

    // 7️⃣ 음악 재생 완료 처리
    private func onMusicCompleted() {
        isMusicPlaying = false
        print("�� 음악 재생 완료!")
    }
}
