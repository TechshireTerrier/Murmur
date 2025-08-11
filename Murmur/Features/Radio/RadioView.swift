//
//  RadioView.swift
//  Murmur
//
//  Created by Muchan Kim on 8/10/25.
//

import SwiftUI

struct RadioView: View {
    @StateObject private var viewModel = RadioViewModel()
    @EnvironmentObject private var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            Color.Gray900
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(height: 244)

                OnAirSignView(isOn: viewModel.isPlaying)
                    .padding(.bottom, 54)

                RadioSubtitleView(subtitle: viewModel.currentSubtitle)

                Spacer()

                // 작성 완료 버튼
                Button {
                    navigationManager.popToRoot()
                } label: {
                    Text("홈으로 이동")
                        .font(.PretendardBodySemiBold)
                        .foregroundColor(Color.Gray900)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(Color.PointMint)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 32)
            }
        }
        .navigationBarBackButtonHidden()
        .enableSwipeBack()
        .toolbar {
            CustomBackButton {
                navigationManager.pop()
            }
        }
        .onAppear {
            viewModel.startPlaying()
        }
        .onDisappear {
            viewModel.stopPlaying()
        }
    }
}

#Preview {
    NavigationView {
        RadioView()
            .environmentObject(NavigationManager())
    }
}
