//
//  RecommendSongTestView.swift
//  Murmur
//
//  Created by 김현기 on 7/17/25.
//

import AVFoundation
import MusicKit
import SwiftUI

struct RecommendSongTestView: View {
    @State private var isMusicAuthorized = false
    // 검색어를 입력받을 상태 변수
    @State private var searchTerm: String = "Happy"

    // ✅ 1. 검색된 플레이리스트와 랜덤으로 선택된 곡을 저장할 상태 변수 추가
    @State private var foundPlaylist: Playlist?
    @State private var recommendedTrack: MusicItemCollection<Track>.Element?

    // AVPlayer를 클래스의 속성으로 선언하여 강한 참조를 유지한다.
    let player: AVPlayer = AVPlayer()
    @State var playerItem: AVPlayerItem?

    var body: some View {
        VStack(spacing: 20) {
            if isMusicAuthorized {
                // 검색 UI
                HStack {
                    TextField("검색어를 입력하세요", text: $searchTerm)
                        .textFieldStyle(.roundedBorder)
                    Button("플레이리스트 검색") {
                        Task {
                            await searchAndRecommendSong()
                        }
                    }
                }
                .padding()

                Divider()

                // ✅ 3. 선택된 곡 정보를 표시하는 UI
                if let song = recommendedTrack {
                    VStack {
                        Text("추천 곡 🎶")
                            .font(.title.bold())

                        if let playlist = foundPlaylist {
                            Text("From '\(playlist.name)'")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        if let artwork = song.artwork {
                            ArtworkImage(artwork, width: 250)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.vertical)
                        }

                        Text(song.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(song.artistName)
                            .font(.headline)
                            .foregroundColor(.secondary)

                        // ✅ 2. 간단 재생 버튼
                        Button(action: {
                            // 버튼을 누르면 바로 노래를 재생
                            play(song)
                        }) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.accentColor)
                        }
                        .padding(.top)
                    }
                } else {
                    Text("추천할 노래를 검색해주세요.")
                }

            } else {
                // 권한이 없을 때 보여줄 뷰
                Text("음악 추천을 받으려면 Apple Music 접근 권한이 필요합니다.")
                Button("권한 요청하기") {
                    Task {
                        await requestMusicAuthorization()
                    }
                }
            }
        }
        .onAppear {
            // 뷰가 처음 나타날 때 현재 권한 상태를 확인
            Task {
                // request()를 바로 호출해도 내부적으로 상태를 확인하므로 괜찮다.
                await requestMusicAuthorization()
            }
        }
    }
}

extension RecommendSongTestView {
    // 1️⃣ MusicKit 권한을 요청하는 비동기 함수
    private func requestMusicAuthorization() async {
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

    // 2️⃣ 검색 및 랜덤 곡 추천 로직을 수행하는 함수
    private func searchAndRecommendSong() async {
        do {
            // 플레이리스트 검색
            var request = MusicCatalogSearchRequest(term: searchTerm, types: [Playlist.self])
            request.limit = 1
            let response = try await request.response()

            // 검색된 첫 번째 플레이리스트를 가져옴
            guard let foundPlaylist = response.playlists.first else {
                print("검색 결과에 플레이리스트가 없습니다.")
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

    // 3️⃣ 노래를 재생하는 간단한 함수
    private func play(_ track: MusicItemCollection<Track>.Element) {
        Task {
            guard let previewAsset = track.previewAssets?.first,
                  let url = previewAsset.url
            else {
                print("미리듣기를 지원하지 않는 곡이거나 URL이 없습니다.")
                return
            }

            
            playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            
            player.play()

            print("\(track.title) 30초 미리듣기를 재생합니다.")
        }
    }
}

#Preview {
    RecommendSongTestView()
}
