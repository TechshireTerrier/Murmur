//
//  HomeView.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()

    var body: some View {
        ZStack {
            Color.Gray900
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.gray800)
                    .frame(width: 300, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .strokeBorder(Color.gray50, lineWidth: 10)
                    )
                    .overlay(
                        OnAirTextView(isOn: homeViewModel.haveTodayStory)
                    )
                    .padding(.bottom, 125)

                MurmurButton(
                    action: { print("📝 사연 신청하기") },
                    text: "사연 신청하기",
                    textColor: .text07,
                    bgColor: .keyMint
                )
                .padding(.bottom, 12)

                MurmurButton(
                    action: { print("📖 사연 보기") },
                    text: "사연 보기",
                    textColor: .text07,
                    bgColor: .PointPurple
                )
            }
            .padding(.horizontal, 48)
        }
    }
}

struct OnAirTextView: View {
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
}
