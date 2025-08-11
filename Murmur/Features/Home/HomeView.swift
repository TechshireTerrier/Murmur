//
//  HomeView.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject private var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            Color.Gray900
                .ignoresSafeArea()
            VStack {
                OnAirSignView(isOn: homeViewModel.haveTodayStory)
                    .padding(.bottom, 125)

                MurmurButton(
                    action: {
                        print("📝 사연 신청하기")
                        navigationManager.push(to: .writeStory)
                    },
                    text: "사연 신청하기",
                    textColor: .text07,
                    bgColor: .keyMint
                )
                .accessibilityLabel("사연 신청하기 버튼")
                .padding(.bottom, 12)

                MurmurButton(
                    action: {
                        print("📖 사연 보기")
                        navigationManager.push(to: .totalStoryList)
                    },
                    text: "사연 보기",
                    textColor: .text07,
                    bgColor: .PointPurple
                )
                .accessibilityLabel("사연 보기 버튼")
            }
            .padding(.horizontal, 48)
        }
    }
}

struct OnAirSignView: View {
    let isOn: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.gray800)
            .frame(width: 300, height: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .strokeBorder(Color.gray50, lineWidth: 10)
            )
            .overlay(
                OnAirText(isOn: isOn)
            )
            .accessibilityLabel(isOn ? "ON AIR 불 켜짐" : "ON AIR 불 꺼짐")
            .accessibilityHint(isOn ? "방송 중이에요. 오늘의 사연이 접수되었어요." : "방송 대기 중이에요. 오늘의 사연이 아직 없어요.")
    }
}

struct OnAirText: View {
    let isOn: Bool

    var body: some View {
        Text("ON AIR")
            .font(.PretendardOnAir)
            .lineSpacing(74)
            .kerning(-0.7)
            .foregroundStyle(isOn ? .keyMint : .gray700)
            .shadow(
                color: isOn ? .keyMint : .clear, // isOn 값에 따라 그림자 색상 변경 (끄려면 .clear)
                radius: 5.2,
                x: 0,
                y: 0
            )
    }
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager())
}
