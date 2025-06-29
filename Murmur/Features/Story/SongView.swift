//
//  SongView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct SongView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                SongStoryView()
                DailyEmotionView()
                StoryMusicView()
            }
        }
    }
}

#Preview {
    SongView()
}
