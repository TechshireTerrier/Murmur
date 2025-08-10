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
