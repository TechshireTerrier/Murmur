//
//  TotalStoryListViewModel.swift
//  Murmur
//
//  Created by 김현기 on 6/28/25.
//

import SwiftUI

class TotalStoryListViewModel: ObservableObject {
    @Published var stories: [Story] = []

    // TODO: - 임시
    init() {
        fetchMockStories()
    }

    func fetchMockStories() {
        // 실제 앱에서는 서버 통신 등을 통해 데이터를 가져옵니다.
        // 여기서는 예시 목업 데이터를 사용합니다.
        stories = [
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 1), // 1일 전
                content: "벌써 5월의 마지막 주말이네요. 라일락 꽃잎이 하나둘 떨어지는 걸 보니 괜히 마음이 싱숭생숭해져요. 올해는 유독 시간이 빠르게 흐르는 것 같아요. 붙잡고 싶지만 그럴 수 없으니, 이 순간을 온전히 즐겨야겠죠? 이런 날씨와 기분에 어울리는 노래가 있을까요.",
                recommendedSongAuthor: "아이유",
                recommendedSongTitle: "라일락"
            ),
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 3), // 3일 전
                content: "정신없이 프로젝트 마감일을 향해 달려왔어요. 매일 야근에 주말 출근까지, 정말 번아웃이 오기 직전인 것 같아요. 동료들과 으쌰으쌰하며 버티고는 있지만, 문득 혼자라는 생각이 들 때면 왈칵 눈물이 쏟아질 것 같아요. '괜찮다, 잘하고 있다'는 따뜻한 위로가 담긴 노래를 듣고 싶어요.",
                recommendedSongAuthor: "옥상달빛",
                recommendedSongTitle: "수고했어, 오늘도"
            ),
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 5), // 5일 전
                content: "오랜만에 친구들과 약속을 잡고 밖으로 나왔어요! 날씨도 좋고, 맛있는 음식도 먹고, 그동안 쌓였던 스트레스가 확 풀리는 기분이에요. 이 기세를 몰아 신나는 노래를 크게 틀고 해안도로를 달리고 싶은데, 듣기만 해도 어깨가 들썩이는 펑키한 노래 추천해주세요!",
                recommendedSongAuthor: "Mark Ronson",
                recommendedSongTitle: "Uptown Funk (feat. Bruno Mars)"
            ),
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 7), // 7일 전
                content: "창밖으로 비가 추적추적 내리네요. 이런 날에는 약속도 다 취소하고 집에서 뒹굴거리는 게 최고인 것 같아요. 따뜻한 커피 한 잔 내려서 창가에 앉아 빗소리를 듣고 있으니 마음이 차분해져요. 이 분위기를 더 깊게 만들어 줄 감성적인 연주곡이나 노래가 있다면 알려주세요.",
                recommendedSongAuthor: "에피톤 프로젝트",
                recommendedSongTitle: "선인장"
            ),
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 10), // 10일 전
                content: "모두가 잠든 고요한 새벽, 스탠드 불빛 하나에 의지해 일기를 쓰고 있어요. 하루를 정리하고 내일을 계획하는 이 시간이 저에겐 가장 소중해요. 복잡했던 생각들이 차분하게 가라앉는 느낌이랄까요. 이런 새벽 감성에 푹 빠져들게 할 몽환적인 노래가 듣고 싶네요.",
                recommendedSongAuthor: "검정치마",
                recommendedSongTitle: "EVERYTHING"
            ),
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 12), // 12일 전
                content: "친한 친구가 곧 결혼을 해요. 청첩장을 받으니 제 일처럼 기쁘면서도 한편으로는 조금 섭섭한 마음이 드는 건 어쩔 수 없나 봐요. 함께 교복 입고 떡볶이 먹던 게 엊그제 같은데, 어느새 이렇게 커서 각자의 길을 가고 있네요. 친구의 새로운 시작을 축복해주고 싶은데, 어떤 노래가 좋을까요?",
                recommendedSongAuthor: "아이유",
                recommendedSongTitle: "Blueming"
            ),
            Story(
                createdAt: Date().addingTimeInterval(-86400 * 15), // 15일 전
                content: "오늘 회사에서 큰 실수를 했어요. 다행히 잘 해결되긴 했지만, 하루 종일 제 자신이 너무 바보 같고 위축되는 기분이었어요. 집에 돌아오는 길에 멍하니 버스 창밖만 바라봤네요. 오늘 하루 정말 고생한 저에게 위로를 해주고 싶어요.",
                recommendedSongAuthor: "이하이",
                recommendedSongTitle: "한숨"
            ),
        ]
    }
}
